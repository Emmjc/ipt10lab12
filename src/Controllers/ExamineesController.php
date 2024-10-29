<?php 

namespace App\Controllers;

use App\Models\UserAnswer;
use App\Models\User;
use Fpdf\Fpdf;

class ExamineesController extends BaseController
{
    public function index() {
        $this->initializeSession();

        $userObj = new User();
        $examinees = $userObj->getAllUsers();

        $userAnsObj = new UserAnswer();
        $data = $userAnsObj->getUserAnswers();

        $combinedData = [
            'examinees' => $examinees,
            'data' => $data, 
        ];

        return $this->render('examinees', $combinedData);
    }

    public function exportAttemptToPDF($id)
    {
        // Initialize UserAnswer model
        $userAnsObj = new UserAnswer();
        
        // Fetch attempt details by ID
        $attemptData = $userAnsObj->getAttemptById($id);
        
        if (!$attemptData) {
            echo "Attempt Not Found";
            return;
        }

        // Decode JSON answers
        $answers = json_decode($attemptData['answers'], true);

        // Initialize FPDF and set up the PDF document
        $pdf = new FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Arial', 'B', 16);

        // Header
        $pdf->Cell(0, 10, 'Exam Attempt Details', 0, 1, 'C');
        $pdf->Ln(10);

        // Set font for the content
        $pdf->SetFont('Arial', '', 12);

        // Add Examinee Name
        $pdf->Cell(50, 10, 'Examinee Name:');
        $pdf->Cell(100, 10, $attemptData['examinee_name']);
        $pdf->Ln(10);

        // Add Attempt ID
        $pdf->Cell(50, 10, 'Attempt ID:');
        $pdf->Cell(100, 10, $attemptData['attempt_id']);
        $pdf->Ln(10);

        // Add Date Answered
        $pdf->Cell(50, 10, 'Date Answered:');
        $pdf->Cell(100, 10, $attemptData['date_answered']);
        $pdf->Ln(10);

        // Add Attempt Date
        $pdf->Cell(50, 10, 'Attempt Date:');
        $pdf->Cell(100, 10, $attemptData['attempt_date']);
        $pdf->Ln(10);

        // Add Exam Items
        $pdf->Cell(50, 10, 'Exam Items:');
        $pdf->Cell(100, 10, $attemptData['exam_items']);
        $pdf->Ln(10);

        // Add Exam Score
        $pdf->Cell(50, 10, 'Exam Score:');
        $pdf->Cell(100, 10, $attemptData['score']);
        $pdf->Ln(10);

        // Add Answers header
        $pdf->Cell(50, 10, 'Answers:');
        $pdf->Ln(10);

        // Loop through the answers starting from the second item
        foreach (array_slice($answers, 1) as $index => $answer) {
            $pdf->Cell(10); // Indent
            $pdf->Cell(40, 10, "Question " . ($index + 1) . ": " . (is_bool($answer) ? ($answer ? 'True' : 'False') : $answer));
            $pdf->Ln(8);
        }
        // Output the PDF
        $pdf->Output();
    }
}