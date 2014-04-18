/*
 antiflodd is a daemon that waits for Unflod.dylib and when it is created, it removes the file immediately
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

#include <unistd.h>

bool file_exists() {

	if(access("/Library/MobileSubstrate/DynamicLibraries/Unflod.dylib",F_OK) != -1) {
        return TRUE;
	}

	return FALSE;
}

int main(int argc, char **argv, char **envp) {

	if (file_exists()) {
        
        int rm = system("rm -rf /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib");
    	
    	if (rm == 0) {
    		printf("Unflod.dylib removed\n");
    	}
	}
    
	kill(getpid(),SIGKILL);
    
	return 0;
}

