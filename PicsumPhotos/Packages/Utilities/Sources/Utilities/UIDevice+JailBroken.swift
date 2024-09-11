//
//  UIDevice+JailBroken.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import UIKit

/// UIDevice extension
public extension UIDevice {
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    /**
     Detect that the app is running on a jailbroken device or not
     
     - returns: bool value for jailbroken device or not
     */
    
    var isDeviceJailbroken: Bool {
        get {
#if arch(i386) || arch(x86_64)
            return false
#else
            let fileManager = FileManager.default
            
            if (fileManager.fileExists(atPath: "/bin/bash") ||
                fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
                fileManager.fileExists(atPath: "/etc/apt") ||
                fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
                fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
                fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")) {
                return true
            } else {
                return false
            }
#endif
        }
    }
}
