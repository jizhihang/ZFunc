function Zj_RemoveTilde(file_path)
% automatically remove boring files ending with tilde(~)
% zijun.wei@stonybrook.edy 2015.1.7

cmd=sprintf('rm %s',fullfile(file_path,'*~'));
system(cmd);
end