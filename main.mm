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

bool file_exists() {
        return (access("/Library/MobileSubstrate/DynamicLibraries/Unflod.dylib",F_OK) != -1);
}

int main(int argc, char **argv, char **envp) {

	if (file_exists()) {
        
        FILE *logFile = fopen("/var/log/antiunflodd.log","a+");
        time_t rawtime;
        struct tm * timeinfo;
        time (&rawtime);
        timeinfo = localtime (&rawtime);
        fprintf(logFile, "%s",asctime(timeinfo));
        system("dpkg -S /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib >>/var/log/antiunflodd.log");
        int rm = system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib");
    	
        if (rm == 0) {
            fprintf(logFile,"Removed Unflod.dylib\n\n");
        }
        
        fclose(logFile);
	}
    
    
	kill(getpid(),SIGKILL);
    
	return 0;
}

