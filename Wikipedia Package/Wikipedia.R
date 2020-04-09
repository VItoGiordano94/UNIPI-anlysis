library(tidyverse)
library(WikipediR)
library(rvest)
library(rebus)


# wiki_extract_txt --------------------------------------------------------

wiki_extract_txt <- function(page_name, language = "en"){
  
  # Extract content of Wikipedia Web Page
  
  output <- try(page_content(language = language,"wikipedia", page_name = page_name)$parse$text$'*',silent = TRUE) %>% 
   
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


# wiki_extract_link -------------------------------------------------------

wiki_extract_link <- function(page_name, language = "en"){
  
  # Extract the hyper link of wikipedia page 
  
  output <- page_links(language = language,"wikipedia", page = page_name, limit = 500) %>% 
    .$query %>% 
    .$pages %>% 
    .[[1]] %>% 
    .$links %>% 
    
    # take the second element of each element of a list
    map_chr(c(2))  
  
  # Return output 
  
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


# wiki_extract_traduction -------------------------------------------------

wiki_extract_traduction <- function(page_name, language_in, language_out){
  
  # Remove white space from the page
  
  page_name <- page_name %>% 
    str_replace_all(" ", "_")
  
  # Create the link of page in lenaguage input
  
  page_link <- str_c("https://", language_in, ".wikipedia.org/wiki/", page_name, sep = "")
  
  
  # Search the connection between language input web page and output language web page
  
  html_position <- str_c(".interwiki-", language_out, " .interlanguage-link-target", sep = "")
  
  
  output <- try(read_html(page_link), silent= TRUE)
  
  if(is.list(output)) {
    
    # Extract the name of Wikipedia page in Output language
    
    output <- output %>% 
      html_node(html_position) %>%
      html_attr('href') %>% 
      str_match("wiki/" %R% capture("(.*?)") %R% "$") %>% 
      .[2]
    
    # Manage if the page does not exists
    
  } else output <- "The page doesn't exist."
  
  # Manage if the translation does not exists
  
  if(is.na(output)) output <- "The translation doesn't exist."
  
  # Return Output 
  
  return(output)
  
}


# wiki_extract_categories -------------------------------------------------


wiki_extract_categories <- function(page_name, language = "en"){
  
  # Remove white space from the page
  
  page_name_in <- page_name %>% 
    str_replace_all(" ", "_")
  
  # Extract Wikipedia Category
  
  wiki_dirty <- unlist((categories_in_page(language = language, project="wikipedia", pages = page_name_in))) 
  
  # Transform in vector the extracted category
  
  output <- as.vector(wiki_dirty) %>% 
    str_to_lower() %>% 
    .[grep("category:", .)] %>%
    str_replace_all("category:", "") %>% 
    as_tibble() %>%
    
    # remove the category equal to page name
    filter(!value == page_name) %>% 
    pull(value) %>% 
    str_c(collapse = "; ") 
    
    
  
  # Return Output
  
  return(output)
  
}
