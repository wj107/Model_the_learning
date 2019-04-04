#######################################################
#---script to create "spaghetti state" at random 
#---from L1 session
#######################################################



#---required
require(ggplot2, quietly=T)

#---get map data for all 50 states
states<-map_data("state")

#---find all the states available to me, then pick one at random
state.names<-unique(states$region)
sample(state.names,1)->secret.state

#---extract border data for my 'secret state'
secret.state.border<-subset(states,region==secret.state)

#---scramble that data
secret.state.border<-secret.state.border[sample(1:nrow(secret.state.border)),]

#---plot...
ggplot(
  #---...secret scrambled state!
  data=secret.state.border,
  #---aesthetics
  aes(x=long, y=lat)
)+
  #---aspect ratio!!!
  coord_fixed()+
  #---line, err path geometry
  geom_path()