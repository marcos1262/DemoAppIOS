//
//  File.swift
//  
//
//  Created by Eric Silverberg on 9/18/22.
//

import Foundation
import SwiftUI
import DomainModels
import Utils
import BusinessLogic
import UIComponents
import ViewModels

/// Pages represent the entire thing shown onscreen. Pages take UIState objects.
/// Pages are the top-most thing that we attempt to preview.
public struct CountryDetailsPage: View {
    @Binding var state: CountryDetailsViewModel.State

    public init(state: Binding<CountryDetailsViewModel.State>) {
        self._state = state
    }

    public var body: some View {
        ZStack {
            ProgressIndicator(isLoading: state.isLoading)
            CountryNotFoundErrorView(viewModelState: _state)
            CountryDetailsContent(countryName: $state.map { newState in
                if case .loaded(let details) = newState {
                    return details.country.countryName ?? ""
                } else {
                    return ""
                }
            }.wrappedValue,
                                  detailsText: $state.map { newState in
                if case .loaded(let details) = newState {
                    return details.detailsText ?? ""
                } else {
                    return ""
                }
            }.wrappedValue)
        }
    }
}

struct CountryDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        let countryDetails = CountryDetails(country: Country(regionCode: "us"),
                                            detailsText: "Now is the time for all good men to come to the aid of their country.")

        CountryDetailsPage(state: .constant(.loaded(details: countryDetails)))
    }
}
