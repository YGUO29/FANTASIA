function GenSoundScanScheme
% This function Generate virtual sounds for Scan Scheme Initialization 
% Recording files is better compatible with 32 bit system, so the max time
% to record is 2^32/(2*10e6) ~= 214.7484 seconds

global TP

%% SoundVirtual_ScanScheme_Search_ImageEnable_OFF
S.Title =	'=SoundVirtual_ScanScheme_Search_ImageEnable_OFF';
S.Artist =	['Xindong @ ' datestr(now, 'yyyymmdd-HH')];
S.Comment = [' ',...
    'TrialNames: ',             'SearchScan',                       '; ',...
    'TrialAttenuations: ',      '120',                              '; ',...
    'TrialNumberTotal: ',       '1',                                '; ',...
    'TrialDurTotal(sec): ',   	'Inf',                              '; ',...
    'TrialDurPreStim(sec): ',	'Inf',                              '; ',...
    'TrialDurStim(sec): ',    	'Inf',                              '; ',...
    ''];
audiowrite([S.Title,'.wav'],...
    int16(zeros(1,1)),      TP.D.Sys.Sound.SR,...
    'BitsPerSample',        16,...
    'Title',                S.Title,...
    'Artist',               S.Artist,...
    'Comment',              S.Comment);

%% SoundVirtual_ScanScheme_Search_ImageEnable_ON
S.Title =	'=SoundVirtual_ScanScheme_Search_ImageEnable_ON';
S.Artist =	['Xindong @ ' datestr(now, 'yyyymmdd-HH')];
S.Comment = [' ',...
    'TrialNames: ',             'SearchImage',                      '; ',...
    'TrialAttenuations: ',      '120',                              '; ',...
    'TrialNumberTotal: ',       '1',                                '; ',...
    'TrialDurTotal(sec): ',   	'214',                              '; ',...
    'TrialDurPreStim(sec): ',	'0',                                '; ',...
    'TrialDurStim(sec): ',    	'214',                              '; ',...
    ''];
audiowrite([S.Title,'.wav'],...
    int16(zeros(1,1)),      TP.D.Sys.Sound.SR,...
    'BitsPerSample',        16,...
    'Title',                S.Title,...
    'Artist',               S.Artist,...
    'Comment',              S.Comment);

%% SoundVirtual_ScanScheme_Record_NaN
S.Title =	'=SoundVirtual_ScanScheme_Record';
S.Artist =	['Xindong @ ' datestr(now, 'yyyymmdd-HH')];
S.Comment = [' ',...
    'TrialNames: ',             'RecordNaN',                        '; ',...
    'TrialAttenuations: ',      'NaN',                              '; ',...
    'TrialNumberTotal: ',       'NaN',                              '; ',...
    'TrialDurTotal(sec): ',   	'NaN',                              '; ',...
    'TrialDurPreStim(sec): ',	'NaN',                              '; ',...
    'TrialDurStim(sec): ',    	'NaN',                              '; ',...
    ''];
audiowrite([S.Title,'.wav'],...
    int16(zeros(1,1)),      TP.D.Sys.Sound.SR,...
    'BitsPerSample',        16,...
    'Title',                S.Title,...
    'Artist',               S.Artist,...
    'Comment',              S.Comment);

%% SoundVirtual_ScanScheme_XBlaster
S.Title =	'=SoundVirtual_ScanScheme_XBlaster';
S.Artist =	['Xindong @ ' datestr(now, 'yyyymmdd-HH')];
S.Comment = [' ',...
    'TrialNames: ',             'XBlaster',                         '; ',...
    'TrialAttenuations: ',      'NaN',                              '; ',...
    'TrialNumberTotal: ',       '1',                                '; ',...
    'TrialDurTotal(sec): ',   	'Inf',                              '; ',...
    'TrialDurPreStim(sec): ',	'Inf',                              '; ',...
    'TrialDurStim(sec): ',    	'Inf',                              '; ',...
    ''];
audiowrite([S.Title,'.wav'],...
    int16(zeros(1,1)),      TP.D.Sys.Sound.SR,...
    'BitsPerSample',        16,...
    'Title',                S.Title,...
    'Artist',               S.Artist,...
    'Comment',              S.Comment);