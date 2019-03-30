<div class="container">
    <div class="row vertical-offset-100">
        <div class="col-md-4 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Find A Home</h3>
                </div>
                <div class="panel-body">
                    <form accept-charset="UTF-8" action="<?php echo base_url(); ?>index.php/searchC/get_result"  method="post"">
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control input-sm" placeholder="Minimum Price" name="minimum_price" id="minimum_price" type="text">
                            </div>
                            <div class="form-group">
                                <input class="form-control input-sm" placeholder="Maximum Price" name="maximum_price" id="maximum_price" type="text">
                            </div>
                            <div class="form-group">
                            <select name="location" required>
                                <option  accesskey=""value="location">Division</option>
                                <option value="dhaka">Dhaka</option>
                                <option value="chittagong">Chittagong</option>
                                <option value="mymensingh">Mymensingh</option>
                                <option value="rajshahi">Rajshahi</option>
                                <option value="rangpur">Rangpur</option>
                                <option value="sylhet">Sylhet</option>
                                <option value="khulna">Khulna</option>
                                <option value="barisal">Barisal </option> 
                            </select>
                        </div>
                            <div class="form-group">
                                <input class="form-control input-sm" placeholder="Full Address" name="full_address" id="Key_Words" type="text">
                            </div>
                            <div class="form-group">
                                <input class="form-control input-sm" placeholder="Bed Rooms" name="bedrooms" id="bedrooms" type="text">
                            </div>
                            
                            <div class="form-group">
                                <input class="form-control input-sm" placeholder="Key Words" name="keywords" id="Key_Words" type="text">
                            </div>
                            <input class="btn btn-lg btn-info btn-block" type="submit" name ='search_btn' value="Search">
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>