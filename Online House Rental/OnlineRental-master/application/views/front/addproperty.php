<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="modal-dialog modal-md">
                <div class="panel-heading">	
                    <h3 class="panel-title">Please sign up  <small>It's free!</small></h3>
                </div> 
                <div class="panel-body">
                    <form accept-charset="UTF-8" method="post" action="<?php echo base_url();?>index.php/PropertyC/add_property">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="property_name" id="name" class="form-control input-sm" placeholder="Property Name" required>
                                </div>
                            </div>
                        </div>		
                        
                        <div class="form-group">
                            <select name="division" required>
                                <option  accesskey=""value="division">Division</option>
                                <option value="dhaka">Dhaka</option>
                                <option value="chittagong">Chittagong</option>
                                <option value="mymensingh">Mymensingh</option>
                                <option value="rajshahi">Rajshahi</option>
                                <option value="rangpur">Rangpur</option>
                                <option value="sylhet">Sylhet</option>
                                <option value="khulna">Khulna</option>
                                <option value="barisal">Barisal </option> <!-- dynamically generate !-->
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <input type="text" name="full_address" id="full_address" class="form-control input-sm" placeholder="Full Address" required>
                        </div>
                        
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="rent" id="name" class="form-control input-sm" placeholder="Rent">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <input type="text" name="bed_rooms" id="name" class="form-control input-sm" placeholder="Bed Rooms">
                                </div>
                            </div>
                        </div>
                        <div>
                            Available From:
                            <input type="date" name="available_from">
                        </div>
                        
                        </br>
                        <div class="form-group">
                            <input type="text" name="keywords" id="key_words" class="form-control input-sm" placeholder="Key Words">
                        </div>
                         <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
          
                                    <textarea class="formInput" name="detail_description" placeholder="Detail Description" id="comments" maxlength="1000000" cols="90" rows="6"></textarea>
                                   
                                </div>
                            </div>
                        </div>
                        
                        <input type="submit" value="Add Property" class="btn btn-info btn-block">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>