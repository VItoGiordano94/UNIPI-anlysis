library(tidyverse)
library(WikipediR)
library(rebus)


# wiki_extract_txt --------------------------------------------------------

wiki_extract_txt <- function(page_name){
  
  # Extract content of Wikipedia Web Page
  
  output <- try(page_content("en","wikipedia", page_name = page_name)$parse$text$'*',silent = TRUE) %>% 
   
    # split the text for paragraph <p>
    strsplit(split = "<p>") %>% 
    
    # unlist the text
    unlist() %>% 
    
    # remove all web page nodes
    str_replace_all("<.*?>", "") %>% 
    str_replace_all("\\[.*?\\]", "") %>% 
    str_replace_all("\n", "") 
  
  
  # Manage missing pages
  
  if(str_detect(output[1],pattern  = or("missingtitle","not have an article with this exact name"))) output <- c("", "The page doesn't exist.")
  
  # Return Output
  
  if (length(output) == 1) return(output[1]) else return(output[-1])
  

}

##### wiki_extract_link -----------------

wiki_extract_link <- function(page_name){
  
  output <- page_links("en","wikipedia", page = page_name, limit=500) %>% 
    .$query %>% 
    .$pages %>% 
    .[[1]] %>% 
    .$links %>% 
    # take the second element of each element of a list
    map_chr(c(2))  
  
  return(output)
  
}

##### wiki_extract_list -----------------

wiki_extract_list <- function(page_name){
  
  # Extract the text
  output_txt <- wiki_extract_txt(page_name)
  
  # If text contains Redirect to:, find the redirect
  if(str_detect(output_txt[1],pattern  = "Redirect to:")){
    
    page_name <- str_match(output_txt[1], "Redirect to:" %R% "(.*?)" %R% "<!")[[2]]
    
    # If text is a short name, or similar, extrat the name with a different rule
    if(str_detect(output_txt[1],pattern  = or("From","To") %R% SPACE %R% or("a","other","the"))) 
    {
      page_name <- str_match(page_name, "^" %R% "(.*?)" %R% or("From","To") %R% SPACE %R% or("a","other","the"))[[2]] 
    }
    
    if(str_detect(output_txt[1],pattern  = " This page is a redirect")) 
    {
      page_name <- str_match(page_name, "^" %R% "(.*?)" %R% " This page is a redirect")[[2]] 
    }
    
    output_txt <- wiki_extract_txt(page_name)
    
  }
  
  # Extract the links
  output_links <- wiki_extract_link(page_name)
  
  if(length(wiki_extract_link(page_name)) == 0) output_links <- ""
  
  # Check may refer to
  if(str_detect(output_txt[1],pattern  = "may refer to:")){
    
    output_txt <- "Ambiguous page name (check links)."
    
    
  }
  
  # Join outputs togheter
  output <- list(name= page_name, txt= output_txt, links= output_links)
  
  return(output)
  
}

##### wiki_extract_table -----------------

wiki_extract_table <- function(page_vector){
  
  output <- tibble(name= character(length(page_vector)),
                   txt= list(NULL),
                   definition= character(length(page_vector)),
                   links= character(length(page_vector)))
  
  for(i in seq_along(page_vector)){
    list_i <- wiki_extract_list(page_vector[i])
    output[i,1] <- list_i[[1]]
    output[i,2] <- str_c(list_i[[2]], collapse ="\n")
    # it does not work every time: better to extract the firts element containing (is | are) +  (a | the ..).
    # Test on NCR_Corporation, McAfee
    output[i,3] <- list_i[[2]][1]
    output[i,4] <- str_c(list_i[[3]], collapse =" | ")
    
  }
  
  output <- output %>% 
    mutate(name = str_replace_all(name,"_", " ")) %>% 
    mutate(links = str_replace_all(links,"_", " ")) %>% 
    mutate(name = str_to_lower(name)) %>% 
    mutate(links = str_to_lower(links))
  
  
  return(output)
  
}

##### wiki_extract_traduction -----------------

wiki_extract_traduction <- function(page_name, language_in, language_out){
  
  page_link <- str_c("https://",language_in,".wikipedia.org/wiki/", page_name, collapse = "")
  html_position <- str_c(".interwiki-",language_out," .interlanguage-link-target",collapse = "")
  
  output <- try(read_html(page_link), silent= TRUE)
  
  if(is.list(output)) {
    output <- output %>% 
      html_node(html_position) %>%
      html_attr('href') %>% 
      str_match("wiki/" %R% capture("(.*?)") %R% "$") %>% 
      .[2]
  } else output <- "The page doesn't exist."
  
  if(is.na(output)) output <- "The translation doesn't exist."
  
  return(output)
  
}

##### wiki_extract_categories -----------------

wiki_extract_categories <- function(page_vector){
  
  output_vector <- NULL
  
  for(i in 1:length(page_vector)){
    
    page <- page_vector[i]
    wiki_dirty <- unlist((categories_in_page("en",project="wikipedia", pages =page)))
    wiki_dirty <- as.vector(wiki_dirty)
    wiki_dirty <- wiki_dirty[grep("Category:", wiki_dirty)]
    wiki_dirty <- gsub("Category:","", wiki_dirty)
    wiki_dirty <- paste(wiki_dirty, collapse = "; ")
    output_vector[i] <- wiki_dirty
    
  }
  
  
  for(i in 1:length(page_vector)){
    
    if(output_vector[i]==""){
      page <- page_vector[i]
      wiki_dirty <- unlist((categories_in_page("en",project="wikipedia", pages =tolower(page))))
      wiki_dirty <- as.vector(wiki_dirty)
      wiki_dirty <- wiki_dirty[grep("Category:", wiki_dirty)]
      wiki_dirty <- gsub("Category:","", wiki_dirty)
      wiki_dirty <- paste(wiki_dirty, collapse = "; ")
      output_vector[i] <- wiki_dirty}
    
  }
  
  
  return(output_vector)
  
}

##### technimeter_add_anchors -----------------

technimeter_add_anchors <- function(technimeter_table){
  
  regex_tech <- "^" %R% or1(technimeter_table$name) %R% "$"
  
  #RIVEDERE, prende solo i primi
  anchors_table <- technimeter_table %>% 
    select(name, links) %>% 
    unnest_tokens(link, links, token = "regex", pattern = " \\| ") %>% 
    mutate(is_anchor= str_detect(link, regex_tech)) %>% 
    group_by(name) %>% 
    filter(is_anchor) %>% 
    mutate(anchors = str_c(link, collapse = " | ")) %>% 
    select(-is_anchor, -link) %>% 
    filter(!duplicated(name)) %>% 
    ungroup() 
  
  
  technimeter_table <- technimeter_table %>% 
    left_join(anchors_table)
  
  return(technimeter_table)
  
  
}
