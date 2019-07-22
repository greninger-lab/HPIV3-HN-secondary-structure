library(ggplot2)
setwd('/Volumes/Vikas/shape_stuff/shapemapper_out/227_ecoli_16s_unreversed')

#reading amplicon profile for depth info
amplicon_profile_table<-read.table('/Volumes/Vikas/shape_stuff/shapemapper_out/227_ecoli_16s_unreversed/garret_22619_ecoli_16s_16s_amplicon_profile.txt', header=TRUE)

#read reference map file
reference_16s_map<-read.csv('/Volumes/Vikas/shape_stuff/shapemapper_out/227_ecoli_16s_unreversed/16S.1m7.map', sep = '\t', col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))


#read Garrett's 16s map file
###this file has -min-depth set to 1000 so the reactivity profile actually generates
#test<-read.csv('/Users/gerbix/Documents/garrett/shapemapper_out/22619_ecoli_16s_catted/garret_22619_ecoli_16s_catted_16s_ecoli_amplicon.map', sep = '\t',col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))
garret_16s_map<-read.csv('/Volumes/Vikas/shape_stuff/shapemapper_out/227_ecoli_16s_unreversed/garret_22619_ecoli_16s_16s_amplicon.map', sep = '\t',col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))

#Garret's 16s sequence has 1 extra A nucleotide at the beginning so trimming that off to match with the reference sequence
garret_16s_map<-garret_16s_map[-1,]
garret_16s_map$nucleotide_position<-2:1542


#setting sequences to character instead of factor
garret_16s_map$sequence<-as.character(garret_16s_map$sequence)
reference_16s_map$sequence<-as.character(reference_16s_map$sequence)

#Changing T to U because reference file has T instead of U
for(i in 1:nrow(reference_16s_map)){ 
  if(reference_16s_map$sequence[i]=='T'){ 
    reference_16s_map$sequence[i]<-'U'
    }
  
  }


#new column for if sequences match
reference_16s_map$seq_match<-NA
garret_16s_map$seq_match<-NA
for(i in 1:nrow(reference_16s_map)){ 
  if(reference_16s_map$sequence[i]==garret_16s_map$sequence[i]){ 
    reference_16s_map$seq_match[i]<-'Match'
    garret_16s_map$seq_match[i]<-'Match'
    }
  else{ 
    reference_16s_map$seq_match[i]<-'Mismatch'
    garret_16s_map$seq_match[i]<-'Mismatch'
  }
}


reference_16s_map$file<-'Reference'
garret_16s_map$file<-'Garrett'

to_remove<-c()
to_remove<-append(to_remove,which(garret_16s_map$normalized_reactivity==-999))
to_remove<-append(to_remove,which(reference_16s_map$normalized_reactivity==-999))

removed_garret_16s_map<-garret_16s_map[-to_remove,]
removed_reference_16s_map<-reference_16s_map[-to_remove,]


#combining data frames to put into ggplot
combined_data<-rbind(reference_16s_map,garret_16s_map)
removed_combined_data<-rbind(removed_garret_16s_map,removed_reference_16s_map)

#with all of the data
all_plot<-ggplot(combined_data, aes(x=nucleotide_position, y=normalized_reactivity, color = file))  +
  geom_point()
all_plot

#with the removed data
removed_plot<-ggplot(removed_combined_data, aes(x=nucleotide_position, y=normalized_reactivity, color = file))  +
  geom_point() +
  scale_y_log10()
removed_plot


Absolute_value_dataframe<-data.frame(removed_garret_16s_map$nucleotide_position, removed_garret_16s_map$normalized_reactivity, removed_reference_16s_map$normalized_reactivity)
Absolute_value_dataframe$absDeltareactivity<-(Absolute_value_dataframe$removed_garret_16s_map.normalized_reactivity - Absolute_value_dataframe$removed_reference_16s_map.normalized_reactivity)

absolute_value_plot<-ggplot(Absolute_value_dataframe, aes(x=Absolute_value_dataframe$removed_garret_16s_map.nucleotide_position, y= Absolute_value_dataframe$absDeltareactivity)) + 
  xlab('Nucleotide position')+ 
  ylab('Garret Reactivity - reference reactivity') + 
  geom_point()

absolute_value_plot


#plots by depth
amplicon_profile_table<-amplicon_profile_table[-c(1,2),]

removed_amplicon_profile_table<-amplicon_profile_table[-to_remove,]

combined_depth_table<-cbind(removed_amplicon_profile_table, Absolute_value_dataframe$absDeltareactivity)

colnames(combined_depth_table)[30]<-'delta_reactivity'

#plot of modified sample read depth vs difference in reactivity
reactivity_by_modified_depth<-ggplot(combined_depth_table, aes(x=combined_depth_table$Modified_mapped_depth, y= combined_depth_table$delta_reactivity)) + 
  xlab('Modified sample read depth')+ 
  ylab('Garret Reactivity - reference reactivity') + 
  geom_point()

reactivity_by_modified_depth
ggsave(filename = 'modified_mapped_depth_reactivity_difference.pdf', plot=reactivity_by_modified_depth)


#plot of untreated sample read depth vs difference in reactivity
reactivity_by_untreated_depth<-ggplot(combined_depth_table, aes(x=combined_depth_table$Untreated_mapped_depth, y= combined_depth_table$delta_reactivity)) + 
  xlab('Untreated sample read depth')+ 
  ylab('Garret Reactivity - reference reactivity') + 
  geom_point()

reactivity_by_untreated_depth
ggsave(filename = 'untreated_mapped_depth_reactivity_difference.pdf', plot=reactivity_by_untreated_depth)

#plot of denatured control  read depth vs difference in reactivity
reactivity_by_denatured_control_depth<-ggplot(combined_depth_table, aes(x=combined_depth_table$Denatured_mapped_depth, y= combined_depth_table$delta_reactivity)) + 
  xlab('Denatured control read depth')+ 
  ylab('Garret Reactivity - reference reactivity') + 
  geom_point() 
reactivity_by_denatured_control_depth
ggsave(filename = 'denatured_control_mapped_depth_reactivity_difference.pdf', plot=reactivity_by_denatured_control_depth)

write.csv(combined_depth_table, 'depth_information_table.txt', sep ='\t')



