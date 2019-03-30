<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class SearchC extends CI_Controller{

	public function index(){
        $page_data['page_name']     = "search";
        $page_data['page_title']    = translate('search');
        $this->load->view('front/index', $page_data); 
    }

    function get_result(){
    	// grabe all the values
        
        $minimum_price      =   $this->input->post('minimum_price');
        $maximum_price      =   $this->input->post('maximum_price');
        $division           =   $this->input->post('division') ;
        $bedrooms           =  $this->input->post('bedrooms')  ;
        $keywords           =  $this->input->post('keywords') ;
         
        
        $sql = "SELECT * FROM `property` WHERE ( rent<=? or rent>=? ) and ( division like ? ) and (keywords like ? and bedrooms>= ? ) ";  
        $query = $this->db->query($sql,array($maximum_price,$minimum_price,$division,$keywords,$bedrooms)) ;
        /*
        if ($query->num_rows() > 0)
        {
            foreach ($query->result() as $row)
            {
               echo $row->property_id ;
               echo "</br>" ; 
            }
        }
        */
        
        $page_data['query'] = $query ;
        $page_data['page_name']     = "showresults";
        $page_data['page_title']    = translate('Show Results');
        $this->load->view('front/index', $page_data);
    }

    function error()
    {
        $this->load->view('front/error');
    }
}