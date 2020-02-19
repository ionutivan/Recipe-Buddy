import Foundation
@testable import Recipe_Buddy

class RecipeListWireframeMock {
  var navigationParameter: RecipeListNavigationOption?
}

extension RecipeListWireframeMock: RecipeListWireframeInterface {
  func navigate(to option: RecipeListNavigationOption) {
    navigationParameter = option
  }
}
