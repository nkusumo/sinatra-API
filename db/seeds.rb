GroupMovie.destroy_all
Group.destroy_all
Movie.destroy_all
UserGroup.destroy_all
User.destroy_all
Vote.destroy_all

GroupMovie.reset_pk_sequence
Group.reset_pk_sequence
Movie.reset_pk_sequence
UserGroup.reset_pk_sequence
User.reset_pk_sequence
Vote.reset_pk_sequence

Group.create(group_name: "FlatMates Movie Crew")
Group.create(group_name: "Friday Flix")

users = ["Kyle", "Nisa", "Greg", "Arthur", "Lucy", "Adrienne", "Carlos", "Edward", "Ryan", "Brendan", "Kenny", "Terry", "Shevon", "Adreena", "Zeus", "Darren", "Jack", "Dan"]
users.each {|user| User.create(name: user)}


Movie.create(title: "Spirited Away", genre: "Fantasy", rating: 8.6, release_date: 2001, image: "https://m.media-amazon.com/images/M/MV5BMjlmZmI5MDctNDE2YS00YWE0LWE5ZWItZDBhYWQ0NTcxNWRhXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg")
Movie.create(title: "Harry Potter and the Prisoner of Azkaban", genre: "Adventure", rating: 7.9, release_date: 2004, image: "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg")
Movie.create(title: "Die Hard", genre: "Action", rating: 8.2, release_date: 1998, image: "https://m.media-amazon.com/images/M/MV5BZjRlNDUxZjAtOGQ4OC00OTNlLTgxNmQtYTBmMDgwZmNmNjkxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg")
Movie.create(title: "Mean Girls", genre: "Comedy", rating: 7.0, release_date: 2004, image: "https://m.media-amazon.com/images/M/MV5BMjE1MDQ4MjI1OV5BMl5BanBnXkFtZTcwNzcwODAzMw@@._V1_SX300.jpg")
Movie.create(title: "Knives Out", genre: "Mystery", rating: 7.9, release_date: 2019, image: "https://m.media-amazon.com/images/M/MV5BMGUwZjliMTAtNzAxZi00MWNiLWE2NzgtZGUxMGQxZjhhNDRiXkEyXkFqcGdeQXVyNjU1NzU3MzE@._V1_SX300.jpg")
Movie.create(title: "Minari", genre: "Drama", rating: 7.5, release_date: 2020, image: "https://m.media-amazon.com/images/M/MV5BNWEzOTNjNDgtZDhhYS00ODAxLWIzNGMtYjU3OGZhYmI3ZDU4XkEyXkFqcGdeQXVyMTAzNjk5MDI4._V1_SX300.jpg")
Movie.create(title: "A Quiet Place Part II", genre: "Sci-Fi", rating: 7.5, release_date: 2020, image: "https://m.media-amazon.com/images/M/MV5BMTE2ODU4NDEtNmRjNS00OTk1LTg4NmMtNTAzYzVlNzJmYjgzXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_SX300.jpg")
Movie.create(title: "In the Heights", genre: "Musical", rating: 7.7, release_date: 2021, image: "https://m.media-amazon.com/images/M/MV5BMzM1ZDY0YTktZTYzZi00MjZjLTllMDMtMmNlMmM5NmY4ZjllXkEyXkFqcGdeQXVyMTA1OTcyNDQ4._V1_SX300.jpg")
Movie.create(title: "The Room", genre: "Drama", rating: 3.7, release_date: 2003, image: "https://m.media-amazon.com/images/M/MV5BYjEzN2FlYmYtNDkwMC00NGFkLWE5ODctYmE5NmYxNzE2MmRiXkEyXkFqcGdeQXVyMjMwODc5Mw@@._V1_SX300.jpg")
Movie.create(title: "Toy Story", genre: "Animation, Adventure, Comedy, Family, Fantasy", rating: 8.3, release_date: 1995, image: "https://m.media-amazon.com/images/M/MV5BMDU2ZWJlMjktMTRhMy00ZTA5LWEzNDgtYmNmZTEwZTViZWJkXkEyXkFqcGdeQXVyNDQ2OTk4MzI@._V1_SX300.jpg")

GroupMovie.create(movie_id: 1, group_id: 1)
GroupMovie.create(movie_id: 2, group_id: 1)
GroupMovie.create(movie_id: 3, group_id: 1)
GroupMovie.create(movie_id: 4, group_id: 1)
GroupMovie.create(movie_id: 5, group_id: 1)
GroupMovie.create(movie_id: 6, group_id: 2)
GroupMovie.create(movie_id: 7, group_id: 2)
GroupMovie.create(movie_id: 8, group_id: 2)
GroupMovie.create(movie_id: 9, group_id: 2)
GroupMovie.create(movie_id: 4, group_id: 2)
GroupMovie.create(movie_id: 10, group_id: 1)


User.all.each {|user| UserGroup.create(user_id: user.id, group_id: 1)}

UserGroup.create(user_id: 6, group_id: 2)
UserGroup.create(user_id: 7, group_id: 2)
UserGroup.create(user_id: 8, group_id: 2)
UserGroup.create(user_id: 9, group_id: 2)
UserGroup.create(user_id: 10, group_id: 2)
UserGroup.create(user_id: 4, group_id: 2)

Group.first.update(winner: 10)

# 3 way tie group 2
# Vote.create(user_group_id: 6, movie_id: 1, rank: 1)
# Vote.create(user_group_id: 6, movie_id: 2, rank: 2)
# Vote.create(user_group_id: 6, movie_id: 3, rank: 3)
# Vote.create(user_group_id: 7, movie_id: 3, rank: 1)
# Vote.create(user_group_id: 7, movie_id: 5, rank: 2)
# Vote.create(user_group_id: 7, movie_id: 1, rank: 3)
# Vote.create(user_group_id: 8, movie_id: 2, rank: 1)
# Vote.create(user_group_id: 8, movie_id: 3, rank: 2)
# Vote.create(user_group_id: 8, movie_id: 4, rank: 3)
# Vote.create(user_group_id: 9, movie_id: 1, rank: 1)
# Vote.create(user_group_id: 9, movie_id: 5, rank: 2)
# Vote.create(user_group_id: 9, movie_id: 2, rank: 3)
# Vote.create(user_group_id: 10, movie_id: 2, rank: 1)
# Vote.create(user_group_id: 10, movie_id: 3, rank: 2)
# Vote.create(user_group_id: 10, movie_id: 4, rank: 3)
# Vote.create(user_group_id: 11, movie_id: 3, rank: 1)
# Vote.create(user_group_id: 11, movie_id: 3, rank: 2)
# Vote.create(user_group_id: 11, movie_id: 4, rank: 3)