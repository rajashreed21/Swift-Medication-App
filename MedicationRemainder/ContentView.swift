//
//  ContentView.swift
//  MedicationRemainder
//
//  Created by RPS on 11/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 2.0) {
                NavigationLink(destination: MedicationFormView()) {
                    Text("Add Medication")
                        .padding()
                }
                NavigationLink(destination: ActiveMedicationListView()) {
                    Text("View Active Medications")
                        .padding()
                }
                NavigationLink(destination: MedicationInfoCardView()) {
                    Text("Medication Info Card")
                        .padding()
                }
                NavigationLink(destination: CalendarView()) {
                    Text("Calendar View")
                        .padding()
                }
                NavigationLink(destination: DailyMedicationScheduleView()) {
                    Text("Daily Medication Schedule")
                        .padding()
                }
                NavigationLink(destination: GestureHandling()) {
                    Text("Gesture Handling")
                        .padding()
                }
                NavigationLink(destination: MainView()) {
                    Text("MainView")
                        .padding()
                }            }
            .navigationTitle("Medication Reminder")
            .foregroundColor(.red)
        }
    }
}

/*struct CalendarView: View {
    var body: some View{
 Text("Calendar View")
    }
}*/
struct CalendarView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    
    @State private var selectedDate = Date()
    @State private var monthOffset = 0
    
    var body: some View {
        VStack {
            Text(monthYearText)
                .font(.title)
                .padding()
            
            HStack {
                Button("<") {
                    monthOffset -= 1
                }
                Spacer()
                Button(">") {
                    monthOffset += 1
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(daysInMonth, id: \.self) { day in
                    Text("\(day)")
                        .frame(width: UIScreen.main.bounds.width / 7, height: 40)
                        .background(selectedDate.isSameDay(as: day) ? Color.blue : Color.clear)
                        .onTapGesture {
                            selectedDate = day
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var monthYearText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Calendar.current.date(byAdding: .month, value: monthOffset, to: Date()) ?? Date())
    }
    
    private var daysInMonth: [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: Date())))
        let offsetDate = calendar.date(byAdding: .month, value: monthOffset, to: startDate!)!
        let range = calendar.range(of: .day, in: .month, for: offsetDate)!
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: offsetDate) }
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}


struct MedicationFormView: View {
    @State private var name: String = ""
    @State private var dosage: String = ""
    @State private var frequency: String = ""
    @State private var medications: [Medication] = []

    var body: some View {
        Form {
            Section(header: Text("Medication Details")) {
                TextField("Medication Name", text: $name)
                TextField("Dosage", text: $dosage)
                TextField("Frequency", text: $frequency)
            }
            
            Button("Save") {
                saveMedication()
            }
        }
        .navigationTitle("Add Medication")
    }
    
    private func saveMedication() {
        guard !name.isEmpty && !dosage.isEmpty && !frequency.isEmpty else {
            
            return
        }
        
        let newMedication = Medication(name: name, dosage: dosage, frequency: frequency)
        medications.append(newMedication)
        
        name = ""
        dosage = ""
        frequency = ""
    }
}

struct MedicationFormView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationFormView()
    }
}

struct Medication {
    
    var name: String
    var dosage: String
    var frequency: String
}

     

struct ActiveMedicationListView: View {
    var body: some View {
        List {
            Text("Thyronome Reminder 1")
            Text("Paracetamol Reminder 2")
            Text("Moxikind-Cv375 Remainder 3")
        }
        .navigationTitle("Active Medications")
    }
}

struct MedicationInfoCardView: View {
    var body: some View {
        VStack {
            Text("Next Dose Time: 10:00 AM")
            Text("Remaining Pills: 20")
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct DailyMedicationScheduleView: View {
    var body: some View {
        List {
            Text("Daily Medication Schedule")
                .font(.headline)
            Text("Morning 7:30")
            Text("Evening 5:30")
        }
    }
}


struct GestureHandling: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Angle = .degrees(0)
    @State private var offset: CGSize = .zero

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { _ in
            
            }
        
        let rotationGesture = RotationGesture()
            .onChanged { angle in
                self.rotation = angle
            }
            .onEnded { _ in
                
            }
        
        let magnificationGesture = MagnificationGesture()
            .onChanged { scale in
                self.scale = scale
            }
            .onEnded { _ in
                
            }
        
        return Text("Gesture Handling")
            .font(.largeTitle)
            .scaleEffect(scale)
            .rotationEffect(rotation)
            .offset(offset)
            .gesture(dragGesture.simultaneously(with: rotationGesture).simultaneously(with: magnificationGesture))
    }
}

struct GestureHandling_Previews: PreviewProvider {
    static var previews: some View {
        GestureHandling()
    }
}

               
     

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Salintone ")
                Text("Cetrizine ")
                Text("Vitamin D")
            }
            .navigationTitle("Medications")
            .navigationBarItems(trailing: addButton)
        }
    }

    private var addButton: some View {
        NavigationLink(destination: Text("Medication Form")) {
            Image(systemName: "plus")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


