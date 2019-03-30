<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class PropertyC extends CI_Controller{

	public function index(){
        $page_data['page_name']  = "addproperty";
        // get all he dirstrict names from database
        $this->load->view('front/index', $page_data);
    }
    public function add_property($param="") {
               
        $data['property_name']     =   $this->input->post('property_name');
        $data['division'] = $this->input->post('division');
        $data['full_address']       =   $this->input->post('full_address');
        $data['bedrooms']      =   $this->input->post('bed_rooms');
        $data['rent']      =   $this->input->post('rent');
        $data['keywords']        =   $this->input->post('keywords');
        $data['available_from']      =   $this->input->post('available_from');
        $data['detail_description'] = $this->input->post('detail_description') ;
        $data['owner_id'] = $this->session->userdata('user_id');
        //print_r($data) ; 
        // insert it into database
        $this->db->insert('property' , $data);
        $query = $this->db->get_where('property' , array('property_name' => $data['property_name'] , 'division' => $data['division'],'full_address' => $data['full_address'],'bedrooms' => $data['bedrooms'],'rent' => $data['rent'],'keywords' => $data['keywords'],'available_from' => $data['available_from'],'owner_id' => $data['owner_id'],'detail_description' => $data['detail_description']));
         if ($query->num_rows() > 0){
                    $row = $query->row();
                    //echo $row->property_id ;
                    
                    $page_data['page_name']     = "add_property_image";
                    $page_data['property_id'] = $row->property_id ;
                    $page_data['page_title']    = translate('Add Property Image');
                    $this->load->view('front/index', $page_data);
         }else{
             echo "something went worng" ;
             // something wrong has happened try again
         }
         
       
    }
    public function add_property_image($param=""){
       // echo $param ;
        ///*
        $property_id = $param ;
        $config = array(
            'upload_path' => "./images/properties/",
            'allowed_types' => "gif|jpg|png|jpeg",
            'overwrite' => TRUE,
            'max_size' => "20480000", // Can be set to particular file size
            'max_height' => "1024",
            'max_width' => "2024",
            'file_name' => "property_" . "$property_id"
        );
        
        $this->load->library('upload', $config);
        if ($this->upload->do_upload()) {
            $page_data['page_name'] = "add_property_success";
            $page_data['page_title'] = translate('Add Property Success');
            $page_data['message'] = "Property Has been Added Successfully :)" ;
            $this->load->view('front/index', $page_data);
        } else {
            $page_data['page_name'] = "error";
            $page_data['message'] = " Some Thing Went Worng";
            $this->load->view('front/index', $page_data);
        }         
        // */
    }
    function error()
    {
        $this->load->view('front/error');
    }
}