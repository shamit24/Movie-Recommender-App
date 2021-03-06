library(proxy)
library(recommenderlab)
library(reshape2)
movies <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
ratings <- read.csv("ratings.csv", header = TRUE)

movie_recommendation <- function(movie1, movie2, movie3) {
  row_num <- which(movies[,2] == movie1)
  row_num2 <- which(movies[,2] == movie2)
  row_num3 <- which(movies[,2] == movie3)
  userSelect <- matrix(NA,9724)
  userSelect[row_num] <- 5 #hard code first selection to rating 5
  userSelect[row_num2] <- 4 #hard code second selection to rating 4
  userSelect[row_num3] <- 3 #hard code third selection to rating 3
  userSelect <- t(userSelect)
  
 
  ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
  ratingmat <- as.matrix(ratingmat[,-1]) #remove userIds
  colnames(userSelect) <- colnames(ratingmat)
  ratingmat2 <- rbind(userSelect, ratingmat)
  
  ratingmat2 <- as.matrix(ratingmat2)
  
  #Convert rating matrix into a sparse matrix
  ratingmat2 <- as(ratingmat2, "realRatingMatrix")
  
  #Create Recommender Model. "UBCF" stands for user-based collaborative filtering
  recc_model_UBCF <- Recommender(data = ratingmat2, 
                                 method = "UBCF", param =list(method= "Cosine", nn= 30))
  n_recommender <- 10
  
  recc_predicted_UBCF <- predict(object = recc_model_UBCF, newdata = ratingmat2[1], n = n_recommender)
  
  
  
  recom_list <- as(recc_predicted_UBCF, "list")
  recom_result <- data.frame(matrix(NA,10))
  for (i in c(1:10)){
    recom_result[i,1] <- movies[as.integer(recom_list[[1]][i]),2]
  }
  colnames(recom_result) <- "User-Based Collaborative Filtering Recommended Titles"
  return(recom_result)
}