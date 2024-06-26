import Foundation

class Constans {
    public static let loginController = "LoginController"
    public static let authNavigationController = "AuthNavigationController"
    public static let signupController = "SignupController"
    public static let tabController = "tabController"
    public static let ProfileController = "ProfileController"
    public static let orderController = "OrderController"
    public static let createProductController = "CreateProductController"
    public static let categoryController = "CategoryController"
    public static let categoryHolderController = "CategoryHolderController"
    public static let clothesController = "ClothesController"
    public static let electronicsItemController = "ElectronicsItemController"
    public static let sportsController = "SportsController"
}

class CellIdentifier {
    public static let searchCell = "SearchCell"
    public static let productCell = "ProductCell"
    public static let categoryHolderCell = "CategoryHolderCell"
    public static let categoryCell = "CategoryCell"
    public static let collectionSectionHeaderView = "CollectionSectionHeaderView"
    public static let orderCell = "OrderCell"
}

class RestClient {
    public static let baseUrl = "https://api.escuelajs.co"
    public static let categoryUrl = "/api/v1/categories"
    public static let loginUrl = "/api/v1/auth/login"
    public static let profileUrl = "/api/v1/auth/profile"
    public static let photoUploadUrl = "/api/v1/files/upload"
    public static let productsUrl = "/api/v1/products"
    public static let firstCategoryUrl = "/api/v1/products/?categoryId=1"
    public static let secondCategoryUrl = "/api/v1/products/?categoryId=2"
    public static let thardCategoryUrl = "/api/v1/products/?categoryId=3"
}
