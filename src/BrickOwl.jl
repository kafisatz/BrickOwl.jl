module BrickOwl

using HTTP; using JSON3; using DataFrames

export get_set_ids
function get_set_ids(wishlist_id,bokey)
res = HTTP.get("https://api.brickowl.com/v1/wishlist/lots" *  "?key=$bokey" * "&wishlist_id=$wishlist_id")
rest = JSON3.read(String(res.body))
sets = DataFrame()
for i in 1:size(rest,1)
    tmp1 = filter(x->x.type=="set_number",rest[i].ids)
    set_id = unique(map(x->x.id,tmp1))
    boid = rest[i].boid
    @assert size(set_id,1) == 1
    @show set_id[1]
    df0 = DataFrame(boid=boid,set_id=set_id[1])
    append!(sets,df0)
end 
sets
@assert size(sets,1) == size(rest,1)
return sets 
end

end
