//
//  DispatchQueueTypeMock.swift
//  Telda-MoviesAppTests
//
//  Created by Khaled Elshamy on 29/06/2025.
//

import Foundation
@testable import Telda_MoviesApp

final class DispatchQueueTypeMock: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}
