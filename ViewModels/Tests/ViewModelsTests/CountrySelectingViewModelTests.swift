//
//  File.swift
//
//
//  Created by Eric Silverberg on Sep 18, 2022
//

import Quick
import Nimble
import Swinject
import Foundation
import DomainModels
import CombineExpectations
import Interfaces
import Logic
@testable import ViewModels

final class CountrySelectingViewModelTests: QuickSpec {
    override func spec() {
        describe("CountrySelectingViewModel") {
            var container: Container!
            var viewModel: CountrySelectingViewModel!
            var mockAppScheduler: MockAppSchedulerProviding!

            beforeEach {
                container = Container().injectBusinessLogicRepositories()
                    .injectBusinessLogicLogic()
                    .injectBusinessLogicViewModels()
                    .injectInterfaceLocalMocks()
                    .injectInterfaceRemoteMocks()
                mockAppScheduler = (container.resolve(AppSchedulerProviding.self)! as! MockAppSchedulerProviding)
                mockAppScheduler.useTestMainScheduler = true
                viewModel = container.resolve(CountrySelectingViewModel.self)!
            }

            var stateRecorder: Recorder<CountrySelectingViewModel.UiState, Never>!
            var states: [CountrySelectingViewModel.UiState]!

            beforeEach {
                stateRecorder = viewModel.$state.record()
            }

            it("then it startings having transitioned to .loading") {
                expect(try! stateRecorder.availableElements.get()).to(equal([
                    CountrySelectingViewModel.UiState(isLoading: true, serverStatus: .Empty)]))
            }

            context("when I advance") {
                beforeEach {
                    mockAppScheduler.testScheduler.advance()
                    states = try! stateRecorder.availableElements.get()
                }

                it("then the middle emission is still loading") {
                    expect(states[1].isLoading).to(beTrue())
                    expect(states[1].isLoaded).to(beFalse())
                    expect(states[1].continents.isEmpty).to(beFalse())
                }

                it("then the final emission has loaded") {
                    expect(states[2].isLoading).to(beFalse())
                    expect(states[2].isLoaded).to(beTrue())
                    expect(states[2].continents.isEmpty).to(beFalse())
                }
            }
        }
    }
}
