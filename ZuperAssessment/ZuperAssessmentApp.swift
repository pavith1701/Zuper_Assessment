//
//  ZuperAssessmentApp.swift
//  ZuperAssessment
//
//  Created by Pavithran P K on 10/07/25.
//

import SwiftUI

@main
struct ZuperAssessmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
