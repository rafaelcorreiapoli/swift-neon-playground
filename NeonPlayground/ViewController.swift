//
//  ViewController.swift
//  NeonPlayground
//
//  Created by Rafael Ribeiro Correia on 2/19/17.
//  Copyright © 2017 Rafael Ribeiro Correia. All rights reserved.
//

import UIKit
import Neon
import Iconic
import Kingfisher

struct Post {
  let imageUrl: String
  let userName: String
  let content: String
  let date: Date
  let userScreenName: String
}


class PostCell: UICollectionViewCell {
  let imageViewImage: UIImageView = UIImageView()
  let lblUserName: UILabel = UILabel()
  let lblUserScreenName: UILabel = UILabel()
  let lblContent: UILabel = UILabel()
  let lblDate: UILabel = UILabel()
  let headerContainer: UIView = UIView()
  
  
  override func layoutSubviews() {
    self.backgroundColor = UIColor.purple
    
    self.addSubview(headerContainer)
    self.addSubview(lblContent)
    
    headerContainer.addSubview(imageViewImage)
    headerContainer.addSubview(lblUserName)
    headerContainer.addSubview(lblDate)
    headerContainer.addSubview(lblUserScreenName)
    
    headerContainer.backgroundColor = UIColor.red
    headerContainer.anchorAndFillEdge(.top, xPad: 0, yPad: 0, otherSize: 80)
    
    lblContent.numberOfLines = 0
    
    
//    let leftConstraint = NSLayoutConstraint(item: self, attribute: ., relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 30)
    lblContent.alignAndFillWidth(align: .underMatchingLeft, relativeTo: headerContainer, padding: 10, height: AutoHeight, offset: 10)
//    lblContent.addConstraint(leftConstraint)
    
//    lblContent.anchorAndFillEdge(.bottom, xPad: 10, yPad: 10, otherSize: AutoHeight)
    
    imageViewImage.anchorToEdge(.left, padding: 10, width: 60, height: 60)
    lblUserScreenName.alignAndFillWidth(align: .toTheRightMatchingTop, relativeTo: imageViewImage, padding: 10, height: 20, offset: 0)
    lblUserName.alignAndFillWidth(align: .underMatchingLeft, relativeTo: lblUserScreenName, padding: 20, height: 20, offset: 0)
    lblDate.anchorInCorner(.topRight, xPad: 10, yPad: 10, width: AutoWidth, height: AutoHeight)
  
//    lblUserScreenName.backgroundColor = UIColor.yellow
//    lblUserName.backgroundColor = UIColor.brown
    
    
    super.layoutSubviews()
  }

  func configWithPost(post: Post) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YYYY"
    
    imageViewImage.kf.setImage(with: URL(string: post.imageUrl)!)
    lblUserScreenName.text = post.userScreenName
    lblUserName.text = post.userName
    lblDate.text = dateFormatter.string(from: post.date)
    lblContent.text = post.content
  }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  var posts = [Post]()
  
  let viewContainer: UIView = UIView()
  let headerContainer: UIView = UIView()
  
  var pictureButtonContainer: UIView = UIView()
  var userButtonContainer : UIView = UIView()
  var homeButtonContainer : UIView = UIView()
  var starButtonContainer: UIView = UIView()
  var addButtonContainer: UIView = UIView()
  
  var homeButton: UIImageView = UIImageView()
  var userButton: UIImageView = UIImageView()
  var pictureButton: UIImageView = UIImageView()
  var starButton: UIImageView = UIImageView()
  var addButton: UIImageView = UIImageView()
  
  let buttonRow: UIView = UIView()
  let buttonRow2: UIView =  UIView()
  
  
  let cellIdentifier: String = "postCell"
  
  lazy var collectionView: UICollectionView = {
    let flow = UICollectionViewFlowLayout()
    
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout:  flow)
    flow.estimatedItemSize = CGSize(width: 374, height: 250)
    
    cv.dataSource = self
    cv.delegate = self
    cv.register(PostCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
    cv.backgroundColor = UIColor.yellow

    return cv
  }()
  
  
  func mockPosts() {
    let post1 = Post(imageUrl: "https://unsplash.it/300x300?image=1", userName: "@rafa93br", content: "Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post Conteúdo do post ", date: Date(timeIntervalSince1970: 100), userScreenName: "Rafael Ribeiro Correia")
    let post2 = Post(imageUrl: "https://unsplash.it/300x300?image=2", userName: "@rafa93br", content: "Conteúdo do post", date: Date(timeIntervalSince1970: 200), userScreenName: "Rafael Ribeiro Correia")
    let post3 = Post(imageUrl: "https://unsplash.it/300x300?image=3", userName: "@rafa93br", content: "Conteúdo do post", date: Date(timeIntervalSince1970: 300), userScreenName: "Rafael Ribeiro Correia")
    let post4 = Post(imageUrl: "https://unsplash.it/300x300?image=4", userName: "@rafa93br", content: "Conteúdo do post", date: Date(timeIntervalSince1970: 400), userScreenName: "Rafael Ribeiro Correia")
    
    posts.append(post1)
    posts.append(post2)
    posts.append(post3)
    posts.append(post4)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
    posts.append(post1)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    mockPosts()
    configCollectionView()
    configureViews()
    layoutViews()
  }
  
  
  func configCollectionView() {
//    collectionView.collectionViewLayout = self
    
  }
  
  func configureViews() {
    self.view.backgroundColor = UIColor.lightGray
    
    homeButton = FontAwesomeIcon.homeIcon.getView(width: 20, height: 20, color: UIColor.gray)
    userButton = FontAwesomeIcon.userIcon.getView(width: 20, height: 20, color: UIColor.gray)
    pictureButton = FontAwesomeIcon.pictureIcon.getView(width: 25, height: 20, color: UIColor.gray)
    starButton  = FontAwesomeIcon.starIcon.getView(width: 20, height: 20, color: UIColor.gray)
    addButton  = FontAwesomeIcon.plusIcon.getView(width: 20, height: 20, color: UIColor.gray)
    
    pictureButtonContainer = pictureButton.makeContainer()
    userButtonContainer = userButton.makeContainer()
    homeButtonContainer = homeButton.makeContainer()
    starButtonContainer = starButton.makeContainer()
    addButtonContainer = addButton.makeContainer()
  
    buttonRow.backgroundColor = UIColor.white
    buttonRow2.backgroundColor = UIColor.white
    
    self.view.addSubview(viewContainer)
    
    viewContainer.addSubview(headerContainer)
    viewContainer.addSubview(buttonRow)
    viewContainer.addSubview(buttonRow2)
    viewContainer.addSubview(collectionView)
    
    buttonRow.addSubview(homeButtonContainer)
    buttonRow.addSubview(userButtonContainer)
    
    buttonRow2.addSubview(pictureButtonContainer)
    buttonRow2.addSubview(starButtonContainer)
    buttonRow2.addSubview(addButtonContainer)
  }
  
  
  func layoutViews() {
    viewContainer.fillSuperview(left: 10, right: 10, top: 10, bottom: 10)
    
    headerContainer.anchorAndFillEdge(.top, xPad: 0, yPad: 0, otherSize: 100)
    buttonRow.alignAndFillWidth(align: .underCentered, relativeTo: headerContainer, padding: 0, height: 60)
    buttonRow2.alignAndFillWidth(align: .underCentered, relativeTo: buttonRow, padding: 0, height: 40)
    collectionView.alignAndFill(align: .underCentered, relativeTo: buttonRow2, padding: 10)
    
    buttonRow.groupAndFill(group: .horizontal, views: [homeButtonContainer, userButtonContainer], padding: 0)
    buttonRow2.groupAndFill(group: .horizontal, views: [pictureButtonContainer, starButtonContainer,addButtonContainer], padding: 10)
    
    homeButton.anchorInCenter(width: 20, height: 20)
    userButton.anchorInCenter(width: 20, height: 20)
    pictureButton.anchorInCenter(width: 20, height: 20)
    starButton.anchorInCenter(width: 20, height: 20)
    addButton.anchorInCenter(width: 20, height: 20)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


// MARK: UICollectionViewDelegate
extension ViewController {
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let width = collectionView.frame.width
//    
//    
//    if let cell = collectionView.cellForItem(at: indexPath) as? PostCell {
//      if let text = cell.lblContent.text {
//        print(text)
//      }
//    }
//    
//
//    print(width)
//    return CGSize(width: width, height: 200)
//  }
//  

}


// MARK: UICollectionViewDataSource
extension ViewController {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
//  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return posts.count
//  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PostCell
    cell.configWithPost(post: self.posts[indexPath.row])
    return cell
    
  }
}

// MARK: FontAwesomeIcon
extension FontAwesomeIcon {
  func getView(width: CGFloat, height: CGFloat, color: UIColor) -> UIImageView{
    let imageView = UIImageView(image: self.image(ofSize: CGSize(width: width, height: height), color: color))
    return imageView
  }
}


extension UIImageView {
  func makeContainer() -> UIView {
    let view = UIView(frame: CGRect.zero)
    view.addSubview(self)
    return view
  }
}
