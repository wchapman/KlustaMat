function [ output_args ] = Matlab2RawKWD(waveStruct)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% https://github.com/klusta-team/kwiklib/wiki/Kwik-format

% wchapman 20140822


fname = 'test.raw.kwd';

kwik_version = 2;

hdf5write(fname, '/kwik_version', 2);

hdf5write(fname,'/recordings/0/data', 

end

