<?php
    if ($query->num_rows() > 0) {
       foreach ($query->result() as $row) {
echo '<div class="container margin-bottom-40">' ;
echo  '  <div class="row">' ;
echo  '      <!-- Main Content --> ' ;
echo   '     <div class="col-md-9">' ;
echo     '       <!-- Tab v4 --> ' ;
echo '           <div class="tab-v4 margin-bottom-40"> ' ;
echo   '             <!-- Tab Heading --> ' ;
echo '              <!-- Tab Content --> ' ; 
echo '              <div class="tab-content"> ' ;
echo '                  <div class="tab-pane fade in active" id="tab-v4-a1"> ' ;
echo '                       <div class="row"> ' ;
echo '                           <div class="col-sm-7"> ' ;
echo '                              <!-- Blog Grid --> ' ;
echo '                              <div class="blog-grid sm-margin-bottom-40">' ;
                                     $image_location = base_url() . '/images/properties/property_' . $row->property_id . '.jpg';
echo '                                   <img class="img-responsive" src="'.$image_location.'" alt="">' ;
echo                                   '<h2><a href="blog_single.html">'.$row->property_name.'</a></h2>' ;
echo '                                   <ul class="blog-grid-info">' ;
echo '                                       <li>Alex Amell</li> ' ;
echo '                                       <li>'.$row->available_from.'</li> ' ;
echo '                                       <li><a href="#"><i class="fa fa-comments"></i> 15</a></li> ' ;
echo '                                   </ul>' ;
echo '                                   <p>'.$row->detail_description.'</p>' ;
echo '                                   <a class="r-more" href="blog_single.html">Read More</a>'; 
echo '                               </div>' ;
echo '                               <!-- End Blog Grid --> ' ;
echo '                           </div>' ;
echo '                           </div>' ;
echo '                       </div> ' ;
echo'                    </div>' ;
echo '                 </div>' ;
echo '           </div> ' ;
echo '       </div>' ;
echo '   </div>' ;
       }
    }
       ?>
