# Query result on FPO with pre-builded query ------------------------------

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
