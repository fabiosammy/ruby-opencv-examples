require 'opencv'
include OpenCV

banner = CvMat.new(50, 500, CV_8U, 3).fill!(CvColor::White)
banner.put_text!('My message', CvPoint.new(5, 40), CvFont.new(:simplex), CvColor::Blue)
banner.rectangle!(CvPoint.new(200,10), CvPoint.new(300,40), color: CvColor::Black, thickness: 1)

banner.save_image('images/banner.jpg')
