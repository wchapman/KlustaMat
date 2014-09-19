function [ waveStruct ] = Axona2Matlab(dataPath, prefix)
% outputFiles = klustaMat.Import.Axona2Matlab(input_fnames)
%   Converts raw .# unit recording files from Axona to matlab workspace
%   variables.

% wchapman 20140822

%% Get a list of all of the unit recordings
for i = 1:100
    dotNum{i} = [dataPath filesep prefix '.' num2str(i)];
    ife(i) = exist(dotNum{i},'file');
end
dotNum = dotNum(ife==2);


%% For each file, get the waveforms:
packetLength = 216; %Given in DacqUSBFileFormats.PDF
for i = 1:length(dotNum)
    
     waveStruct(i) = KlustaMat.Internal.initWaveStruct();
    
     fid = fopen(dotNum{i},'r','ieee-be'); %file formats PDF specifies big-endian
     for k = 1:14, fgetl(fid); end %14 full lines of metadata
     
      headerSize = ftell(fid) + 10; %skip "data_start" then immediately begin binary
      fseek(fid,0,1); % find end of file
      Npackets = floor((ftell(fid)-headerSize)/packetLength); % determine total number of packets in file

      fseek(fid,headerSize,-1); %rewind the file to end of header

      %For each packet, read the timestamp and 50 8bit samples for all 4 channels

      time_stamps = nan(1,Npackets);
      wave = int8(nan(Npackets,50,4));
      
      for j = 1:Npackets
        time_stamps(j)= fread(fid,1,'int32')/96000; %divide by time base
        wave(j,:,1)=fread(fid,50,'int8');

        [~] = fread(fid,1,'int32')/96000;
        wave(j,:,2)=fread(fid,50,'int8');

        [~] = fread(fid,1,'int32')/96000;
        wave(j,:,3)=fread(fid,50,'int8');

        [~] = fread(fid,1,'int32')/96000;
        wave(j,:,4)=fread(fid,50,'int8');
      end
     
     waveStruct(i).name = dotNum{i};
     waveStruct(i).wave = double(wave);
     waveStruct(i).ts = time_stamps(:);
     waveStruct(i).ChannelNumber = str2num(dotNum{i}(strfind(dotNum{i},'.')+1:end));
    
     fp = dotNum{i}(1:strfind(dotNum{i},'.')-1);
     waveStruct(i).fet = [fp '.fet.' num2str(waveStruct(i).ChannelNumber)];
     waveStruct(i).clu = [fp '.clu.' num2str(waveStruct(i).ChannelNumber)];
     waveStruct(i).out = [fp '_' num2str(waveStruct(i).ChannelNumber) '.cut'];
     
     fclose(fid);
     
     waveStruct(i).cellWave = mat2cell(double(wave),ones(size(wave,1),1),size(wave,2),ones(size(wave,3),1));
end

waveStruct = waveStruct(:);

end

