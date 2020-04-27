# patent_count_query ------------------------------------------------------

patent_count_query <- function(query, uspat = "on", usapp = "on", 
                               eupat = "on", stemming = "off", jp = "off", pct = "off",
                               depat = "off"){
  
  # Modify Query
  
  query <- query %>% 
    str_replace_all("(?<=[\\s])\\s*|^\\s+|\\s+$", "")	%>% 
    str_replace_all(" AND ", "+AND+") %>% 
    str_replace_all(" OR ", "+OR+") %>% 
    str_replace_all("\\(","%28") %>% 
    str_replace_all("\\)","%29") %>% 
    str_replace_all('"',"%22") %>% 
    str_replace_all(" ", "+") %>% 
    str_replace_all("&", "%26") %>% 
    str_replace_all("/", "%2F")
  
  # Create Link
  
  link <- str_c("http://www.freepatentsonline.com/result.html?p=1&edit_alert=&srch=xprtsrch&query_txt=",query,
                "&uspat=", uspat,
                "&usapp=", usapp,
                "&eupat=", eupat,
                "&jp=", jp,
                "&pct=", pct,
                "&depat=", depat,
                "&date_range=all&stemming=", stemming,
                "&sort=relevance&search=Search",sep = "")
  
  page <- read_html(link)
  
  n_patents <- html_nodes(page,"#results .well-small td:nth-child(1)") %>% 
    as.character() %>% 
    str_squish() %>% 
    str_replace_all(".*of " ,"") %>%
    str_remove_all("</td>") %>% 
    as.numeric()
  
  # Menage non retireved patents
  
  if(length(n_patents) == 0){
    
    n_patents <- 0
    
    }
  
  # Return output
  
  return (n_patents)
  
}



# patent_ref --------------------------------------------------------------


patent_ref <- function(query, uspat = "on", usapp = "on", 
                       eupat = "on", stemming = "off", jp = "off", pct = "off",
                       depat = "off", p_start = 1, p_end = FALSE){
  # Modify Query
  
  query <- query %>% 
    str_replace_all("(?<=[\\s])\\s*|^\\s+|\\s+$", "")	%>% 
    str_replace_all(" AND ", "+AND+") %>% 
    str_replace_all(" OR ", "+OR+") %>% 
    str_replace_all("\\(","%28") %>% 
    str_replace_all("\\)","%29") %>% 
    str_replace_all('"',"%22") %>% 
    str_replace_all(" ", "+") %>% 
    str_replace_all("&", "%26") %>% 
    str_replace_all("/", "%2F")
  
  # Manage the case when p_end is not setting
  
  if(p_end == FALSE){
    
    p_end <- round(patent_count_query(query, uspat, usapp, eupat, stemming, jp, pct,
                                depat)/50)
    
  }
  
  # create output
  
  output <- vector("character")
  
  # Extract the patents reference for all page from p_start to p_end
  
  for(i in p_start:p_end){
    
    # create the link
    
    link <- str_c("http://www.freepatentsonline.com/result.html?",
                  "p=", i,
                  "&edit_alert=&srch=xprtsrch&query_txt=",query,
                  "&uspat=", uspat,
                  "&usapp=", usapp,
                  "&eupat=", eupat,
                  "&jp=", jp,
                  "&pct=", pct,
                  "&depat=", depat,
                  "&date_range=all&stemming=", stemming,
                  "&sort=relevance&search=Search",sep = "")
    
    page <- read_html(link)
    
    # Extract the patents referens in a page
    
    tmp <- html_nodes(page,"#results td:nth-child(3)") %>% 
      as.character() %>% 
      str_extract("<a href=.*.html") %>% 
      str_remove('<a href=\"') %>% 
      str_remove("^/") %>% 
      str_c("http://www.freepatentsonline.com/", .)
    
    output <- c(output, tmp)
    
    # Print the completed portion
    
    print(str_c("Completed ====== > ", round(i/p_end, 4) * 100, "%"))
    
  }
  
  
  return(output)
}


# patent_title ------------------------------------------------------------

patent_title <- function(link){
  
  page <- read_html(link)
  
  # Extract title
 output <-  html_nodes(page,"font b") %>% 
    as.character() %>% 
    str_remove("<b>") %>% 
    str_remove("</b>") %>% 
    str_trim
 
 # Menage if the result is not found
 
 if(length(output) == 0){
   
   output <- "Not Found"
   
 }
 
 return(output)
  
}



# patent_abs --------------------------------------------------------------


patent_abs <- function(link){
  
  # read page
  
  page <- read_html(link)
  
  
  # Extract asbstract 
  
  output <- html_nodes(page, ".disp_doc2:nth-child(9) .disp_elm_text") %>% 
    as.character() %>% 
    str_remove("<div class=\"disp_elm_text\">") %>% 
    str_remove("</div>") %>% 
    str_trim()
  
  
  # Alternative node if the output have length equal to zero
  
  if(length(output) == 0){
    
    output <- html_nodes(page, "table+ .disp_doc2 .disp_elm_text") %>% 
      as.character() %>% 
      str_remove("<div class=\"disp_elm_text\">") %>% 
      str_remove("</div>") %>% 
      str_trim()
    
  }
  
  
  # Menage if the result is not found
  
  if(length(output) == 0){
    
    output <- "Not Found"
    
  }
  
  return(output)
  
}



# patent_query ------------------------------------------------------------

patent_query <- function(query, uspat = "on", usapp = "on", 
                         eupat = "on", stemming = "off", jp = "off", pct = "off",
                         depat = "off", p_start = 1, p_end = FALSE){
 
   # Clean query 
  
  query <- query %>% 
    str_replace_all("(?<=[\\s])\\s*|^\\s+|\\s+$", "")	%>% 
    str_replace_all(" AND ", "+AND+") %>% 
    str_replace_all(" OR ", "+OR+") %>% 
    str_replace_all("\\(","%28") %>% 
    str_replace_all("\\)","%29") %>% 
    str_replace_all('"',"%22") %>% 
    str_replace_all(" ", "+") %>% 
    str_replace_all("&", "%26") %>% 
    str_replace_all("/", "%2F")
  
  # Inizializate outpuet
  
  output <- tibble(
    link = patent_ref(query, uspat, usapp, eupat, stemming, jp, pct, depat, p_start, p_end)
  )
  
  
  # Inizializate title and abstract column
  
  output <- output %>% 
    mutate(title = "", 
           abs = "")
  
  # Extract title and abstract
  
  for(i in 1:nrow(output)){
    
    # extract title
    output$title[i] <- patent_title(output$link[i])
    
    # extract abs
    output$abs[i] <- patent_abs(output$link[i])
    
    # Pirnt completed operations
    
    print(str_c("Completed ====== > ", round(i/nrow(output), 4) * 100, "%"))
    
  }
  
  # Menage non retireved patents
  
  if(nrow(output) == 0){
    
    output <- "No results"
    
  }
  
  return(output)
  
}
