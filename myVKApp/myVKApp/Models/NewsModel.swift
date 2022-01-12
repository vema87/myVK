//
//  NewsModel.swift
//  myVKApp
//
//  Created by Sergey Makeev on 16.12.2021.
//

import UIKit

struct NewsModel {
	let newsShortDescription: String
	let newsImage: UIImage?
}

// Singleton news
class News {
	static let shared: News = News()
	
	var newsList: [NewsModel] = [
		NewsModel(newsShortDescription: """
   Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software and online services. Apple is the largest information technolog company by revenue (totaling $274.5 billion in 2020) and, since January 2021, the world's most valuable company. As of 2021, Apple is the fourth-largest PC vendor by unit sales[9] and fourth-largest smartphone manufacturer.[10][11] It is one of the Big Five American information technology companies, alongside Amazon, Google (Alphabet), Facebook (Meta), and Microsoft.
   """,
				  newsImage: UIImage(named: "news1")),
		NewsModel(newsShortDescription: """
  Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones	and tablets. Android is developed by a consortium of developers known as the Open Handset Alliance and commercially sponsored by Google. It was unveiled in November 2007, with the first commercial Android device, the HTC Dream, being launched in September 2008.
  """,
				  newsImage: UIImage(named: "news2"))
	]
	
	private init() {}
	
	
}
