//
//  ReachabilityManager.swift
//  BearShop
//
//  Created by Sushobhit.Jain on 05/10/21.
//

import Foundation
import UIKit
import Network


/// Protocol for listenig network status change
public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.Connection)
}
let sharedAppDelegate = UIApplication.shared.delegate as? AppDelegate

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    private override init() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to start")
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                print("Network Path:  We're connected!")
            } else {
                print("Network Path:    No connection.")
               
                // remove the top view controller if it is offline view.
                
            }

            print(path.isExpensive)
        }
        
    }
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    
    var reachabilityStatus: Reachability.Connection = .unavailable
    
    private var reachability:Reachability!
    
    let monitor = NWPathMonitor()

    var listeners = [NetworkStatusListener]()
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        
        if let reachability = notification.object as? Reachability {
            
            switch reachability.connection {
            case .unavailable:
                debugPrint("Network became unreachable")
            case .wifi:
                debugPrint("Network reachable through WiFi")
            case .cellular:
                debugPrint("Network reachable through Cellular Data")
            case .none:
                debugPrint("Network status not identified")
            }
            
            if reachability.connection == .unavailable {
                // present the offline view
                let offlineVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OfflineViewController") as! OfflineViewController
                
                sharedAppDelegate?.window?.rootViewController.present(offlineVC, animated: true, completion: {
                    
                })
                
            } else {
                // remove the top view controller if it is offline view.
                sharedAppDelegate?.window?.rootViewController?.presentedViewController?.dismiss(animated: false, completion: {
                    
                })
            }
            
            //        // Sending message to each of the delegates
            //        for listener in listeners {
            //            listener.networkStatusDidChange(status: reachability.connection)
            //        }
        }
    }
    /// Starts monitoring the network availability status
    func startMonitoring() {
        print("Started notifying")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring() {
        print("Stopped notifying")
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    /*
    /// Adds a new listener to the listeners array
    ///
    /// - parameter delegate: a new listener
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }*/
    
    deinit {
        print("\(self) destroyed")
    }
}
