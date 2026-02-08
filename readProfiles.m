function profiles = readProfiles(Profile_File_Address)
profiles = [];
% Profile_File_Address = 'profiles.txt';
file_content = fileread(Profile_File_Address);
file_content_lines = regexp(file_content, '\n', 'split');
first_str = '[x0, xend; y0, yend]';
if sum(file_content_lines{1}(1:end - 1) == first_str) == size(first_str, 2)
    for i = 2:length(file_content_lines)
        profiles = [profiles, str2num(file_content_lines{i})];
    end
else
    display('Please load a proper file as profile!')
end
end