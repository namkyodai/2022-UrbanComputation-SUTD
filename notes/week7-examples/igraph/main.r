library(igraph)
g1 <- graph( edges=c(1,2, 2,3, 3, 1), n=3, directed=F ) 
plot(g1)

g2 <- graph( edges=c(1,2, 2,3, 3, 1), n=10 )

plot(g2)  

g3 <- graph( c("John", "Jim", "Jim", "Jill", "Jill", "John")) # named vertices

# When the edge list has vertex names, the number of nodes is not needed

plot(g3)


g4 <- graph( c("John", "Jim", "Jim", "Jack", "Jim", "Jack", "John", "John"), 
             
             isolates=c("Jesse", "Janis", "Jennifer", "Justin") )  

# In named graphs we can specify isolates by providing a list of their names.



plot(g4, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, 
     
     vertex.frame.color="gray", vertex.label.color="black", 
     
     vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.5) 

plot(graph_from_literal(a---b, b---c)) # the number of dashes doesn't matter

plot(graph_from_literal(a--+b, b+--c))

plot(graph_from_literal(a+-+b, b+-+c)) 

plot(graph_from_literal(a:b:c---c:d:e))


gl <- graph_from_literal(a-b-c-d-e-f, a-g-h-b, h-e:f:i, j)

plot(gl)

E(g4)

V(g4)


g4[]

g4[1,]


V(g4)$name


V(g4)$gender <- c("male", "male", "male", "male", "female", "female", "male")

E(g4)$type <- "email"

E(g4)$weight <- 10    # Edge weight, setting all existing edges to 10
E(g4)


E(g4)



g4 <- set_graph_attr(g4, "name", "Email Network")

g4 <- set_graph_attr(g4, "something", "A thing")



graph_attr_names(g4)


graph_attr(g4, "name")

graph_attr(g4)

g4 <- delete_graph_attr(g4, "something")

graph_attr(g4)



plot(g4, edge.arrow.size=.5, vertex.label.color="black", vertex.label.dist=1.5,
     
     vertex.color=c( "pink", "skyblue")[1+(V(g4)$gender=="male")] ) 


g4s <- simplify( g4, remove.multiple = T, remove.loops = F, 
                 
                 edge.attr.comb=c(weight="sum", type="ignore") )

plot(g4s, vertex.label.dist=1.5)

eg <- make_empty_graph(40)

plot(eg, vertex.size=10, vertex.label=NA)


fg <- make_full_graph(40)

plot(fg, vertex.size=10, vertex.label=NA)


st <- make_star(40)

plot(st, vertex.size=10, vertex.label=NA)



tr <- make_tree(40, children = 3, mode = "undirected")

plot(tr, vertex.size=10, vertex.label=NA)


rn <- make_ring(40)

plot(rn, vertex.size=10, vertex.label=NA)


er <- sample_gnm(n=100, m=40) 

plot(er, vertex.size=6, vertex.label=NA)  



sw <- sample_smallworld(dim=2, size=10, nei=1, p=0.1)

plot(sw, vertex.size=6, vertex.label=NA, layout=layout_in_circle)


ba <-  sample_pa(n=100, power=1, m=1,  directed=F)

plot(ba, vertex.size=6, vertex.label=NA)


## Example

transport <- graph( edges=c(1,2,
                            1,3,
                            1,4,
                            2,5,
                            2,6,
                            3,6,
                            4,6,
                            4,7,
                            4,9,
                            5,8,
                            5,9,
                            5,6,
                            6,9,
                            7,9,
                            7,10,
                            8,11,
                            9,11,
                            9,12,
                            10,11,
                            10,12,
                            11,12)) 
plot(transport)


topo_sort(transport)


L3 <- LETTERS[1:8]
d <- data.frame(start = sample(L3, 16, replace = T), end = sample(L3, 16, replace = T),
                weight = c(20,40,20,30,50,60,20,30,20,40,20,30,50,60,20,30))


g <- graph.data.frame(d, directed = T)


V(g)$name 
E(g)$weight

ideg <- degree(g, mode = "in", loops = F)
ideg
col=rainbow(12) # For edge colors

plot.igraph(g, 
            vertex.label = V(g)$name, vertex.label.color = "gray20",
            vertex.size = ideg*25 + 40, vertex.size2 = 30,
            vertex.color = "gray90", vertex.frame.color = "gray20",
            vertex.shape = "rectangle",
            edge.arrow.size=0.5, edge.color=col, edge.width = E(g)$weight / 10,
            edge.curved = T, 
            layout = layout.reingold.tilford)


l <-layout.reingold.tilford(g) 
l
plot.igraph(g, 
             vertex.label = V(g)$name, vertex.label.color = "gray20",
             vertex.size = ideg*25 + 40, vertex.size2 = 30,
             vertex.color = "gray90", vertex.frame.color = "gray20",
             vertex.shape = "rectangle",
             edge.arrow.size=0.5, edge.color=col, edge.width = E(g)$weight / 10,
             edge.curved = T, 
             layout = l)

igraph_options(plot.layout=layout_as_tree)

plot(make_tree(20, 2))
plot(make_tree(50, 3), vertex.size=3, vertex.label=NA)
tkplot(make_tree(50, 2, mode="undirected"), vertex.size=10,
       vertex.color="green")
plot(transport)

G <- graph( c(1,2,1,3,1,4,3,4,3,5,5,6,6,7,7,8,8,9,3,8,5,8), directed = FALSE )
# visualization
plot(G, layout = layout.fruchterman.reingold,
     vertex.size = 25,
     vertex.color="red",
     vertex.frame.color= "white",
     vertex.label.color = "white",
     vertex.label.family = "sans",
     edge.width=2,  
     edge.color="black")


data <- matrix(sample(0:1, 100, replace=TRUE, prob=c(0.8,0.2)), nc=10)
data
network <- graph_from_adjacency_matrix(data , mode='undirected', diag=F )
plot(network)
