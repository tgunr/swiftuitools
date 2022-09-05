//
//  ContentView.swift
//  SwiftUI Text Tools
//
//  Created by Dave Carlton on 8/8/21.
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        HStack {
            VStack {
                Image("xcswift")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("SwiftUI Tools")
                Text("Version 1.0")
            }
            .padding(.horizontal)
        }
    }
}

struct InstallView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("SwiftUI Tools")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                Text("To install:")
                    .padding(.bottom, 1.0)
                Text("1) Copy/Move this app to /Applications")
                Text("2) Open app in /Applications")
                Text("3) Open 'System Preferences->Extensions->Xcode Source Editor'")
                Text("4) Enable 'SwiftUI Text Tools'")
                Text("5) Open Xcode")
                Text("6) Select 'Editor->SwiftUI Tools'")
                Text("7) Close this app")
                Text("8) Create key binding for commands (optional)")
            }
            .padding(.leading)
        }
    }
}

struct UninstallView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("SwiftUI Tools")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                Text("To uninstall:")
                    .padding(.bottom, 1.0)
                Text("1) Remove this app from /Applications")
                Text("2) Open 'System Preferences->Extensions->Xcode Source Editor'")
                Text("3) 'SwiftUI Text Tools' should be gone")
            }
            .padding(.leading)
        }
    }
}

struct ToggleUsage: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select a something on a line containing an opening {")
            Text("Typically you should select something in front of the { e.g. HStack {")
                .font(.caption)
            Text("Toggle Brace")
                .font(.headline)
                .padding(.top, -1.0)
            Text("Toggle Brace Lines")
                .font(.headline)
                .padding(.top, -1.0)
        }
        .tabItem {
            Text("Toggle")
        }
    }
}

struct RemoveUsage: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select a something on a line containing an opening {")
            Text("Typically you should select something in front of the { e.g. HStack {")
                .font(.caption)
            Text("Remove Brace")
                .font(.headline)
                .padding(.top, -1.0)
            Text("Remove Brace Lines")
                .font(.headline)
                .padding(.top, -1.0)
        }
            .tabItem {
                Text("Remove")
            }
    }
}

struct UsageView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
            Text("SwiftUI Tools")
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                .padding(.bottom)
                Text("There are two modes for these tools.")
                    .padding(.bottom, -2.0)
                Text("Brace")
                    .font(.headline)
                Text("Operation on an opening brace and its matching closing brace")
                Text("Brace Lines")
                    .font(.headline)
                    .padding(.top, -1.0)
                Text("Operation on the lines between opening brace and the closing brace, including the brace lines.")
            }
            TabView {
                RemoveUsage()
                ToggleUsage()
            }
        }
    }
}

struct OptionsView: View {
    var body: some View {
        Text("Options")
    }
}


struct ContentView: View {
    var body: some View {
        HStack {
            VersionView()
            VStack {
                TabView {
                    UsageView()
                        .tabItem {
                        Text("Usage")
                    }
                    InstallView()
                        .tabItem {
                        Text("Installation")
                    }
                    UninstallView()
                        .tabItem {
                        Text("Uninstall")
                    }
                }
            }
        }
        .padding([.bottom, .trailing])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

