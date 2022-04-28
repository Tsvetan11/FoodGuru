//
//  LandingScreen.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 27.04.22.
//

import SwiftUI

struct LandingScreen: View {

	// MARK: - Constants

	private enum Constants {
		static let screenSize = UIScreen.main.bounds.size
		static let logoWidth: CGFloat = screenSize.width * 0.5
		static let logoHeight: CGFloat = screenSize.width * 0.5
		static let logoImage = UIImage(named: "FoodGuru")!
		static let logoBottomPadding: CGFloat = 20
		static let labelHorizontalPadding: CGFloat = 20
		static let labelText = "Welcome to FoodGuru your best friend when you are hungry"
		static let buttonTitle = "Get started"
		static let buttonTopPadding: CGFloat = 100
		static let buttonBottomPadding: CGFloat = 20
		static let buttonWidth: CGFloat = 120
		static let buttonHeight: CGFloat = 50
		static let buttonCornerRadius: CGFloat = 30
		static let progeressViewScale: CGFloat = 1.5
		static let logoAnimationWidth: CGFloat = 70
		static let animationDuration = 1.0
	}

	// MARK: - Variables

	@State private var animate = false
	@State private var showHomeScreen = false
	
	@State private var animateLogo = false {
		didSet {
			if animateLogo {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					withAnimation(.easeInOut(duration: Constants.animationDuration)) {
						animateLogo = false
					}
				}
			}
		}
	}

	// MARK: - Body

    var body: some View {
		VStack {
			NavigationLink(destination: Text("Test"), isActive: $showHomeScreen) { EmptyView() }

			logo

			label

			ZStack {
				buttonLoadingView
				getStartedButton
			}
		}
		.frame(maxWidth: Constants.screenSize.width,
			   maxHeight: Constants.screenSize.height)
		.background(
			Color.yellow
				.ignoresSafeArea(.all)
		)
    }
}

// MARK: - Views

extension LandingScreen {
	private var logo: some View {
		Image(uiImage: Constants.logoImage)
			.resizable()
			.frame(width: animateLogo ? Constants.logoWidth - Constants.logoAnimationWidth : Constants.logoWidth,
				   height: Constants.logoHeight)
			.padding(.bottom, Constants.logoBottomPadding)
			.onTapGesture {
				withAnimation(.easeInOut(duration: Constants.animationDuration)) {
					animateLogo = true
				}
			}
	}

	private var label: some View {
		Text(Constants.labelText)
			.multilineTextAlignment(.center)
			.font(.title2)
			.foregroundColor(.white)
			.padding(.horizontal, Constants.labelHorizontalPadding)
	}

	private var getStartedButton: some View {
		Button(Constants.buttonTitle) {
			withAnimation {
				animate.toggle()
			}

			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				showHomeScreen.toggle()

				withAnimation {
					animate.toggle()
				}
			}
		}
		.foregroundColor(.white)
		.frame(width: animate ? .zero : Constants.buttonWidth,
			   height: animate ? .zero : Constants.buttonHeight)
		.background(
			Color.red
				.cornerRadius(Constants.buttonCornerRadius)
		)
		.padding(.top, Constants.buttonTopPadding)
		.padding(.bottom, Constants.buttonBottomPadding)
	}

	private var buttonLoadingView: some View {
		ProgressView()
			.progressViewStyle(CircularProgressViewStyle(tint: .red))
			.scaleEffect(Constants.progeressViewScale)
			.padding(.top, Constants.buttonTopPadding)
	}
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
