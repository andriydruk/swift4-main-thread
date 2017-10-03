import Foundation
import Glibc

let group = DispatchGroup()

let checkIsMainThread: () -> Void = {
	if Thread.isMainThread {
		print("Thread #\(gettid()) isMainThread")
	}
	else {
		print("Thread #\(gettid()) NOT MainThread")
	}
}

let defaultQueue = DispatchQueue.global()
defaultQueue.async(group: group, execute: checkIsMainThread)

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
userInteractiveQueue.async(group: group, execute: checkIsMainThread)

let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
userInitiatedQueue.async(group: group, execute: checkIsMainThread)

let utilityQueue = DispatchQueue.global(qos: .utility)
utilityQueue.async(group: group, execute: checkIsMainThread)

let backgroundQueue = DispatchQueue.global(qos: .background) 
backgroundQueue.async(group: group, execute: checkIsMainThread)

let mainQueue = DispatchQueue.main 
mainQueue.async(group: group, execute: checkIsMainThread)

checkIsMainThread()

group.wait()