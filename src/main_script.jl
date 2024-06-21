using BrickOwl;using JSON3; using HTTP; using DataFrames

credfi = joinpath(ENV["USERPROFILE"],"brickowl.key.txt")
@assert isfile(credfi)
bokey = read(credfi, String);

#user details
res = HTTP.get("https://api.brickowl.com/v1/user/details" *  "?key=$bokey")
rest = JSON3.read(String(res.body))

#wishlist
res = HTTP.get("https://api.brickowl.com/v1/wishlist/lists" *  "?key=$bokey")
rest = JSON3.read(String(res.body))
wishlist_id = rest[1]["wishlist_id"]

lidf = get_set_ids(wishlist_id,bokey)

#get prices

GET https://api.brickowl.com/v1/catalog/lookup

#note you need to write to the BrickOwl admins to get access to the Catalog API
boid = "116843"
#catalog information
res = HTTP.get("https://api.brickowl.com/v1/catalog/lookup" *  "?key=$bokey" * "?boid=$boid")
rest = JSON3.read(String(res.body))


#availability
country="CH"
res = HTTP.get("https://api.brickowl.com/v1/catalog/lookup" *  "?key=$bokey" * "?boid=$boid" * "?country=$country")
rest = JSON3.read(String(res.body))

GET https://api.brickowl.com/v1/catalog/availability
