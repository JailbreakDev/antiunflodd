/*
 antiunflodd is a daemon that waits for Unflod.dylib and when it is created, it removes the file immediately
 Copyright (C) 2014  Jack (sharedRoutine)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.

 */

#include <time.h>
#include <unistd.h>
#include <stdio.h>

bool file_exists(const char *path) {
        return (access(path,F_OK) != -1);
}

int main(int argc, char **argv, char **envp) {

    FILE *logFile = fopen("/var/log/antiunflodd.log","a+");
    time_t rawtime;
    struct tm * timeinfo;
    time (&rawtime);
    timeinfo = localtime (&rawtime);
    fprintf(logFile, "%s",asctime(timeinfo));
    
	if (file_exists("/Library/MobileSubstrate/DynamicLibraries/Unflod.dylib")) {
        system("dpkg -S /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib >>/var/log/antiunflodd.log");
        system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib");
        system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unflod.plist");
        fprintf(logFile,"Removed Unflod.dylib\n\n");
	}
    
    if (file_exists("/Library/MobileSubstrate/DynamicLibraries/Unfold.dylib")) {
        system("dpkg -S /Library/MobileSubstrate/DynamicLibraries/Unfold.dylib >>/var/log/antiunflodd.log");
        system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unfold.dylib");
        system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unfold.plist");
        fprintf(logFile,"Removed Unfold.dylib\n\n");
	}
    
    if (file_exists("/Library/MobileSubstrate/DynamicLibraries/framework.dylib")) {
        system("dpkg -S /Library/MobileSubstrate/DynamicLibraries/framework.dylib >>/var/log/antiunflodd.log");
        system("rm -rf /Library/MobileSubstrate/DynamicLibraries/framework.dylib");
        fprintf(logFile,"Removed framework.dylib\n\n");
    }
    
    fclose(logFile);
	return 0;
}

