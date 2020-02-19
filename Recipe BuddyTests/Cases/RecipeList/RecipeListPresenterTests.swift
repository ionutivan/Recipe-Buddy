import XCTest
@testable import Recipe_Buddy

class RecipeListPresenterTests: XCTestCase {
    
  // MARK: - Navigation
  func test_pressFavorites_callsWireframeWithRightParameter() {
    let wireframe = RecipeListWireframeMock()
    let interactor = RecipeListInteractor()
    let view = RecipeListViewController()
    let presenter = RecipeListPresenter(wireframe: wireframe, interactor: interactor, view: view)
    presenter.didTapFavorites()
    XCTAssertEqual(wireframe.navigationParameter, RecipeListNavigationOption.favorites)
  }

}
