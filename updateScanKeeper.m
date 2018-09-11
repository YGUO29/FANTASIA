function updateScanKeeper(~,evnt)
% updateScanKeeper is called when hTask_AI_6115 updates
% Count Update and Volume #, Record and Save Data
% And Call scanStopped to Stop when at the end of a volume and 
%   Either Time is up, Or Stop Flag is raised 
% for 2D random 256p         on T5810

global TP
persistent Udone
persistent Tdone
persistent TimeStampUpdt

%% Record Instant Update Time 
TimeStampUpdt = now;                                            % Read Current Time

%% Stream and Save Data
    if TP.D.Exp.BCD.ImageEnable
        TP.D.Vol.DataColRaw = evnt.data;                            % Read PMT data
        fwrite(TP.D.Trl.StreamFid, TP.D.Vol.DataColRaw, 'int16');   % Save Streaming Data 
        % record 0.9s data takes ~9ms to log on to harddrive (T3500, 12GB RAM, Raid 0, 7200rpm x2)
    end

%% Update Imaging Time & GUI

    TP.D.Trl.Udone =	TP.D.Trl.Udone + 1;                          	% always integer
    Udone =             TP.D.Trl.Udone;
    TP.D.Trl.Vdone =    TP.D.Trl.Udone * TP.D.Exp.BCD.ImageNumVlmePerUpdt;	% can be float
    TP.D.Trl.Vnum =     ceil(TP.D.Trl.Vdone);
    TP.D.Trl.Unum =     mod(TP.D.Trl.Udone-1, TP.D.Exp.BCD.ImageNumUpdtPerVlme)+1;
                                                                        
    % Record System Status, if Imaging
    if TP.D.Exp.BCD.ImageEnable
        TP.D.Trl.VS.TimeStampUpdt(Udone) =           	TimeStampUpdt;
        TP.D.Trl.VS.PMT_PMTctrl(Udone) =               	TP.D.Mon.PMT.PMTctrl;
        TP.D.Trl.VS.PMT_FANctrl(Udone) =               	TP.D.Mon.PMT.FANctrl;
        TP.D.Trl.VS.PMT_PELctrl(Udone) =              	TP.D.Mon.PMT.PELctrl;
        TP.D.Trl.VS.PMT_StatusLED(Udone,:) =            TP.D.Mon.PMT.StatusLED';
        TP.D.Trl.VS.PMT_CtrlGainValue(Udone) =       	TP.D.Mon.PMT.CtrlGainValue;
        TP.D.Trl.VS.PMT_MontGainValue(Udone) =        	TP.D.Mon.PMT.MontGainValue;
        TP.D.Trl.VS.PMT_MontGainNoise(Udone) =        	TP.D.Mon.PMT.MontGainNoise;
        TP.D.Trl.VS.Power_AOD_CtrlAmpValue(Udone) =  	TP.D.Mon.Power.AOD_CtrlAmpValue;
        TP.D.Trl.VS.Power_AOD_MontAmpValue(Udone,:) =	TP.D.Mon.Power.AOD_MontAmpValue;
        TP.D.Trl.VS.Power_AOD_MontAmpNoise(Udone,:) = 	TP.D.Mon.Power.AOD_MontAmpNoise;
        TP.D.Trl.VS.Power_PmeasuredS121C(Udone)=     	TP.D.Mon.Power.PmeasuredS121C;
        TP.D.Trl.VS.Power_PinferredAtCtx(Udone)=     	TP.D.Mon.Power.PinferredAtCtx;
    end
    
    % Tdone, and  UI Update. Precision is 100ms
    Tdone =     TP.D.Trl.Udone * TP.D.Exp.BCD.ImageNumSmplPerUpdt /...
                TP.D.Sys.NI.Task_AI_6115_SR;
    Tdone =     floor(Tdone*10)/10;
    if TP.D.Trl.Tdone ~= Tdone
        % avoid too fast UI update when volume rate is too high
        % the updating rate is <10Hz
        TP.D.Trl.Tdone = Tdone;
        set(TP.UI.H.hTrl_Tdone_Edit, 'string', sprintf('%5.1f',TP.D.Trl.Tdone));
    end
    
%% Imaging Update
% Render the Image for Dispaly
if TP.D.Mon.Image.DisplayEnable    
    % Imaging Reconstruction
    feval(TP.D.Exp.BCD.ImageImgFunc);    
    % Image Display
    set(TP.UI.H0.hImage,    'cdata', ...
        TP.D.Vol.LayerDisp{ (TP.D.Exp.BCD.ScanNumLayrPerVlme+1)/2 } );
    % Histogram Display
    updateImageHistogram(TP.UI.H0.Hist0);
end

%% Check if Timeout
    if Tdone >=TP.D.Trl.Tmax
        % Time & Flag, for Stopping
        TP.D.Trl.StartTrigStop =        -3;    
        %   -3 = Timeout,       -2 = Stopping by GUI,   -1=Stopping by ExtTrig, 
        %   0 = Stopped,        1 = Started,            2 = Triggered
        TP.D.Trl.TimeStampStopping =	datestr(now, 'dd-mmm-yyyy HH:MM:SS.FFF');
        % GUI Exclusive StartTrigStop Selection
        h = get(TP.UI.H.hTrl_StartTrigStop_Rocker, 'Children');
        set(TP.UI.H.hTrl_StartTrigStop_Rocker, 'SelectedObject', h(1));
        % MSG LOG 
        msg = [datestr(now, 'yy/mm/dd HH:MM:SS.FFF') '\tupdateScanKeeper\tScanning Stopping since timeout\r\n'];
    end

%% Whether Stop HouseKeeping
if  TP.D.Trl.StartTrigStop<0 && TP.D.Trl.Vdone==TP.D.Trl.Vnum 
    % if Trl.StartTrigStop <0
    %   -1: External trigger falling edge triggered scanStopping
    %   -2: GUI / GUI_ScanStartTrigStop called scanStopping
    %   -3: Time out from up here 
    % then check out whether it's a full volume or not, if yes, stop
    scanStopped;
end

