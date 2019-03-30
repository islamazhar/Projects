<div class="container">
    <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
            <div class="modal-dialog modal-md">
                <div class="panel-heading">	
                    <h3 class="panel-title">Please sign up  <small>It's free!</small></h3>
                </div> 
                <div class="panel-body">
                    
                    <?php echo form_open_multipart('PropertyC/add_property_image/'.$property_id);?> 
                        <label>Select Your Image File</label></br></br>  
                        <input type='file' name='userfile' size='20' id='file'/></br> 
                        <input type="submit" value="Add Property Image" class="btn btn-info btn-block">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>