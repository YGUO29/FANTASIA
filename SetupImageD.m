function msg = SetupImageD
% Setup When Trial Started

global TP

% TP.D.Vol Memory Allocation or Registration
TP.D.Vol.DataColRaw =           zeros(  TP.D.Ses.Image.NumSmplPerUpdt, 1,	'int16');
TP.D.Vol.DataColFlt =           zeros(  TP.D.Ses.Image.NumSmplPerUpdt, 1,   'single');
TP.D.Vol.PixlSmplMat =          zeros(  TP.D.Ses.Image.NumPixlPerUpdt, ...
                                        TP.D.Ses.Image.NumSmplPerPixl,      'single');
TP.D.Vol.PixlCol =              zeros(  TP.D.Ses.Image.NumPixlPerUpdt, 1,   'single');
TP.D.Vol.PixlCol2 =          	zeros(  TP.D.Ses.Image.NumPixlPerUpdt, 1,   'single');

% temp overwrite
TP.D.Ses.Image.NumPixlPerEdge = 150;

%% Image
switch TP.D.Ses.Scan.Mode 
    case '2D random'                   
        TP.D.Vol.LayerAbs{1} =  zeros(  TP.D.Ses.Scan.NumPixlPerAxis, ...
                                        TP.D.Ses.Scan.NumPixlPerAxis,       'single');
        TP.D.Vol.LayerDisp{1} = zeros(  TP.D.Ses.Scan.NumPixlPerAxis,...
                                        TP.D.Ses.Scan.NumPixlPerAxis,...
                                        3,                                  'uint8');
        TP.D.Ses.Image.ImgFunc = 'updateImage2Drandom';
    case '2D raster'         
        TP.D.Vol.LayerAbsRaw{1} = ...
                                zeros(  TP.D.Ses.Scan.NumPixlPerAxis, ...
                                        TP.D.Ses.Scan.NumPixlPerAxis-1,     'single');
        TP.D.Vol.LayerAbs{1} = 	zeros(  TP.D.Ses.Scan.NumPixlPerAxis,...
                                        TP.D.Ses.Scan.NumPixlPerAxis-1, ...
                                                                            'single');
        TP.D.Vol.LayerAbsTR{1}= zeros(  TP.D.Ses.Scan.NumPixlPerAxis-1,...
                                        TP.D.Ses.Scan.NumPixlPerAxis, ...
                                                                            'single');                                                                        
        TP.D.Vol.LayerDisp{1} = zeros(  TP.D.Ses.Scan.NumPixlPerAxis-1,...
                                        TP.D.Ses.Scan.NumPixlPerAxis, ...
                                        3,                                  'uint8');
        TP.D.Ses.Image.ImgFunc = 'updateImage';
    case '3D raster'   
        
        TP.D.Ses.Image.NumPixlPerEdge = NaN; % debugging assumption
        for i = 1:TP.D.Ses.Scan.NumLayrPerVlme
        TP.D.Vol.LayerAbsRaw{i} = ...
                                zeros(  TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis, ...
                                        TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis-1, ...
                                                                            'single');
        TP.D.Vol.LayerAbs{i} = 	zeros(  TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis, ...
                                        TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis-1, ...
                                                                            'single');
        TP.D.Vol.LayerDisp{i} = zeros( 	TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis, ...
                                        TP.D.Ses.Scan.ScanInd{i}.NumPixlPerAxis-1, ...     
                                        3,                                  'uint8');
        end
        TP.D.Ses.Image.ImgFunc = 'updateImage3Draster'; 

    otherwise
end

msg = '';