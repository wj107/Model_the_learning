###################################################
#---script to create "highlighted county map" 
#---from L2 session
###################################################


#---required!!
require(ggplot2)

#---get USA county-level data
dat<-map_data("county")

#---focus on just illinois
IL<-subset(dat,region=="illinois")

#---find all county names
county.names<-unique(IL$subregion)
#---pick one at random
random.county<-sample(county.names,1)

#---create identifier vector... simple logical test
county.identifier<-IL$subregion==random.county
#---add identifier to data frame
IL<-data.frame(IL,county.identifier)

#---create IL county map, using identifier to distinguish color
IL.county<-
  #---ggplot!!
  ggplot(
    #---Illinois county boundaries
    data=IL,
    #---aesthetics
    aes(
      #---long and lat
      x=long,
      y=lat,
      #---group county boundaries together
      group=subregion
    )    
  )+
  
  #---add geometry -- polygons!!
  geom_polygon(
    #---set line color
    color="black",
    #---FILL COLOR DISTINGUISHED BY COUNTY IDENTIFIER!!!
    aes(fill=county.identifier)
  )+
  
  #---aspect ratio!!!
  coord_fixed()+
  
  #---get rid of axis titles!
  xlab(NULL)+
  ylab(NULL)+
  
  #---get rid of numbers on the axes!!
  scale_x_continuous(breaks=NULL)+
  scale_y_continuous(breaks=NULL)+
  
  #---scale for fill allows custom setting of colors
  scale_fill_manual(
    #---values is a named vector -- level and color.
    values=(
      c(
        "TRUE"="red",
        "FALSE"="grey79"
      )
    )
  )+
  
  #---no guide, err, legend, for fill
  guides(fill="none")

#---PLOT!!!
IL.county



