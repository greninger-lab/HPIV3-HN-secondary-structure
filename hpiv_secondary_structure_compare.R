library(ggplot2)
setwd('/Volumes/Vikas/shape_stuff/shapemapper_out/')

#reading amplicon profile for depth info
amplicon_profile_table<-read.table('/Users/gerbix/Documents/garrett/shapemapper_out/3119_attempt_1_hpiv3/garret_3119_attempt1_hpiv_s29_ref_hpiv3_amplicon_from_s29_profile.txt', header=TRUE)

#read reference map file
attempt_1<-read.csv('/Users/gerbix/Documents/garrett/shapemapper_out/3119_attempt_1_hpiv3/garret_3119_attempt1_hpiv_s29_ref_hpiv3_amplicon_from_s29.map', sep = '\t', col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))


#read Garrett's 16s map file
###this file has -min-depth set to 1000 so the reactivity profile actually generates
#test<-read.csv('/Users/gerbix/Documents/garrett/shapemapper_out/22619_ecoli_16s_catted/garret_22619_ecoli_16s_catted_16s_ecoli_amplicon.map', sep = '\t',col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))
attempt_3<-read.csv('/Users/gerbix/Documents/garrett/shapemapper_out/3119_attempt_3_hpiv/garret_3119_attempt3_hpiv_s29_ref_hpiv3_amplicon_from_s29.map', sep = '\t',col.names = c('nucleotide_position', 'normalized_reactivity', 'stderr', 'sequence'))

#Garret's hpiv sequence has 1 extra A nucleotide at the beginning so trimming that off to match with the reference sequence
#attempt_3<-attempt_3[-1,]
#attempt_3$nucleotide_position<-2:1884


#setting sequences to character instead of factor
attempt_3$sequence<-as.character(attempt_3$sequence)
attempt_1$sequence<-as.character(attempt_1$sequence)

#Changing T to U because reference file has T instead of U
# for(i in 1:nrow(attempt_1)){ 
#   if(attempt_1$sequence[i]=='T'){ 
#     attempt_1$sequence[i]<-'U'
#     }
#   
#   }


#new column for if sequences match
attempt_1$seq_match<-NA
attempt_3$seq_match<-NA
for(i in 1:nrow(attempt_1)){ 
  if(attempt_1$sequence[i]==attempt_3$sequence[i]){ 
    attempt_1$seq_match[i]<-'Match'
    attempt_3$seq_match[i]<-'Match'
    }
  else{ 
    attempt_1$seq_match[i]<-'Mismatch'
    attempt_3$seq_match[i]<-'Mismatch'
  }
}



attempt_1$file<-'Reference'
attempt_3$file<-'Garrett'

to_remove<-c()
to_remove<-append(to_remove,which(attempt_3$normalized_reactivity==-999))
to_remove<-append(to_remove,which(attempt_1$normalized_reactivity==-999))

removed_attempt_3<-attempt_3[-to_remove,]
removed_attempt_1<-attempt_1[-to_remove,]


#combining data frames to put into ggplot
combined_data<-rbind(attempt_1,attempt_3)
removed_combined_data<-rbind(removed_attempt_3,removed_attempt_1)

#with all of the data
all_plot<-ggplot(combined_data, aes(x=nucleotide_position, y=normalized_reactivity, color = file))  +
  geom_point()
all_plot

#with the removed data
removed_plot<-ggplot(removed_combined_data, aes(x=nucleotide_position, y=normalized_reactivity, color = file))  +
  geom_point() 
  #scale_y_log10()
removed_plot


Difference_dataframe<-data.frame(removed_attempt_3$nucleotide_position, removed_attempt_3$normalized_reactivity, removed_attempt_1$normalized_reactivity)
Difference_dataframe$absDeltareactivity<-(Difference_dataframe$removed_attempt_3.normalized_reactivity - Difference_dataframe$removed_attempt_1.normalized_reactivity)

Difference_plot<-ggplot(Difference_dataframe, aes(x=Difference_dataframe$removed_attempt_3.nucleotide_position, y= Difference_dataframe$absDeltareactivity)) + 
  xlab('Nucleotide position')+ 
  ylab('Garret Reactivity - reference reactivity') + 
  geom_point()

Difference_plot


#plots by depth
amplicon_profile_table<-amplicon_profile_table[-c(1,2),]

removed_amplicon_profile_table<-amplicon_profile_table[-to_remove,]

combined_depth_table<-cbind(removed_amplicon_profile_table, Difference_dataframe$absDeltareactivity)

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



