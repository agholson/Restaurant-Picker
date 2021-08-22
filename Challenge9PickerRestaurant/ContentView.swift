//
//  ContentView.swift
//  Challenge9PickerRestaurant
//
//  Created by Shepherd on 8/17/21.
//

import SwiftUI

struct ContentView: View {
    
    // Selected location
    @State var location = ["Los Angeles", "Queens", "Manhattan", "DC", "Miami", "Chicago", "Detroit"]
    
    @State var locationIndex = 0
    
    // Tracks the index for the person's order
    @State var orderIndex = 0
    
    @State var foodItems = ["Salame", "Speck", "Spaghetti", "Gnocchi", "Lasagna", "Bistecca fiorentina"]
    
    
    // Use this property to note our date
    @State var orderDate = Date()
    
    // Setup our time range from the current time until 10pm that evening
    let timeRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        // Get the current time
        let currentDate = Date()
        
        // Get current minute/ hour to use in our starting date/time range
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinute = calendar.component(.minute, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)

        // Set datetime objects with the starting/ stopping information
        let startComponents = DateComponents(year: currentYear, month: currentMonth, day: currentDay, hour: currentHour, minute: currentMinute)
        let endComponents = DateComponents(year: startComponents.year, month: startComponents.month, day: startComponents.day, hour: 21, minute: 59)
        
        // Return our calendar date/ time ranges
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        VStack {
            // MARK: Title
            Text("Ottimo Ristorante")
                .font(.largeTitle)
            
            Spacer()
            
            // MARK: Location with Menu Picker
            HStack {
                Picker("Select Location: ", selection: $locationIndex) {
                    // Loop through each element in our location list with a Text view
                    ForEach(0..<location.count) { index in
                        Text("\(location[index])")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Text("\(location[locationIndex])")
                
            }
            
            Spacer()
            
            // MARK: Order
            Text("Order")
            Picker("Order:", selection: $orderIndex) {
                ForEach(0..<foodItems.count, content: { index in
                    Text("\(foodItems[index])")
                })
                
            }
            .navigationBarHidden(true)
            
            Spacer()
            
            // MARK: Pickup Time
            DatePicker(
                "Pickup",
                selection: $orderDate,
                in: timeRange,
                displayedComponents: [.hourAndMinute]
            )
            .padding()
            .datePickerStyle(WheelDatePickerStyle())
            
            // MARK: Pick for me
            Button(action: {
                // Call the method, which will randomly change the indexes we use to track all of this
                chooseItem()
            }) {
                Text("Order for me!")
            }
            .padding()
            
        }
            
    }
    
    // MARK: Method to randomly choose the order, location, and time
    func chooseItem() {
        // Sets the locationIndex to a random element within the range of the location list. We say 0 to less than the count of the list
        locationIndex = Int.random(in: 0..<location.count)
        
        // Repeate for our orderIndex
        orderIndex = Int.random(in: 0..<foodItems.count)
        
        // Set the pickup time
        let calendar = Calendar.current
        // Get the current time
        let currentDate = Date()
        
        // Gets the current hour
        let currentHour = calendar.component(.hour, from: currentDate)
        
        // Setup date components to hold our new time
        var components = DateComponents()
        
        // Sets the hour from now until 10pm closing time
        components.hour = Int.random(in: currentHour..<22)
        
        // Sets the minute to anything between 1-59
        components.minute = Int.random(in: 1...59)
        
        // Makes sure it's still only today
        components.year = calendar.component(.year, from: currentDate)
        components.month = calendar.component(.month, from: currentDate)
        components.day = calendar.component(.month, from: currentDate)
        
        // Set our order date to anything
        orderDate = Calendar.current.date(from: components)!
        
        print(orderDate)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
