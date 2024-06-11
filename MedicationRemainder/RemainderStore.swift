//
//  RemainderStore.swift
//  MedicationRemainder
//
//  Created by RPS on 11/06/24.
//

import Foundation
import SwiftUI
import Combine

class ReminderStore: ObservableObject {
  @Published var reminders: [Reminder] = []
}

struct Reminder {
  var id: UUID = UUID()
  var name: String
  var dosage: String
  var frequency: String
}
