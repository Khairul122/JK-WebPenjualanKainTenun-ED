<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Invoice extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();

        if ($this->session->userdata('level') != '1') {
            redirect('welcome');
        }
    }

    public function index()
    {
        $data['title'] = 'Invoice';
        $data['invoice'] = $this->model_invoice->get();
        $this->load->view('layout/admin/header', $data);
        $this->load->view('admin/payment/invoice', $data);
        $this->load->view('layout/admin/footer');
    }

    public function detail($id_invoice)
    {
        $data['title'] = 'Detail Checkout';
        $data['invoice'] = $this->model_invoice->get_id_invoice($id_invoice);
        $data['pesanan'] = $this->model_invoice->get_id_pesanan($id_invoice);
        $this->load->view('layout/admin/header', $data);
        $this->load->view('admin/payment/detail_invoice', $data);
        $this->load->view('layout/admin/footer');
    }

    public function confirm($id)
    {
        $this->db->update('transaction', ['status' => '1'], ['order_id' => $id]);
        $_SESSION["sukses"] = 'Pesanan berhasil di konfirmasi';
        redirect('admin/invoice');
    }

    public function pdf()
    {
        $data['title'] = 'PDF Report';
        $data['data_orders'] = $this->model_invoice->get_all();
        
        if (!$data['data_orders']) {
            $data['data_orders'] = [];
        }
        $this->load->library('pdf');
        $this->pdf->setPaper('A4', 'portrait');
        $this->pdf->filename = "Invoice Bill.pdf";
        $this->pdf->load_view('admin/payment/pdf', $data);
    }


    public function filter_by_date()
    {
        // Pastikan tanggal awal dan tanggal akhir telah diset
        $start_date = $this->input->post('start_date'); // Ambil tanggal awal dari form
        $end_date = $this->input->post('end_date'); // Ambil tanggal akhir dari form
    
        // Pastikan tanggal awal dan tanggal akhir tidak kosong
        if (!empty($start_date) && !empty($end_date)) {
            // Panggil model untuk melakukan filtering data
            $data['data_orders'] = $this->model_invoice->filter_by_date($start_date, $end_date);
    
            // Load view dengan data yang sudah difilter
            $data['title'] = 'Filtered Invoice';
            $data['start_date'] = $start_date;
            $data['end_date'] = $end_date;
            $this->load->view('layout/admin/header', $data);
            $this->load->view('admin/payment/invoice', $data);
            $this->load->view('layout/admin/footer');
        } else {
            // Tampilkan pesan jika tanggal awal atau tanggal akhir kosong
            echo "Tanggal awal dan akhir harus diisi";
        }
    }
    

    public function print_by_date()
    {
        // Pastikan tanggal awal dan tanggal akhir telah diset
        $start_date = $this->input->post('start_date'); // Ambil tanggal awal dari form
        $end_date = $this->input->post('end_date'); // Ambil tanggal akhir dari form

        // Pastikan tanggal awal dan tanggal akhir tidak kosong
        if (!empty($start_date) && !empty($end_date)) {
            // Panggil model untuk melakukan filtering data
            $data['data_orders'] = $this->model_invoice->filter_by_date($start_date, $end_date);

            // Load view dengan data yang sudah difilter
            $data['title'] = 'Printed Invoice';
            $data['start_date'] = $start_date; // Menyertakan tanggal awal
            $data['end_date'] = $end_date; // Menyertakan tanggal akhir
            $this->load->library('pdf');
            $this->pdf->setPaper('A4', 'portrait'); // Potrait bukan potrait
            $this->pdf->filename = "Invoice_Report_" . date('Y-m-d') . ".pdf";
            $this->pdf->load_view('admin/payment/filter_pdf', $data);
        } else {
            // Tampilkan pesan jika tanggal awal atau tanggal akhir kosong
            echo "Tanggal awal dan akhir harus diisi";
        }
    }
}
