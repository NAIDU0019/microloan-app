import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/input_field.dart';
import '../utils/validators.dart';

class LoanApplyScreen extends StatefulWidget {
  const LoanApplyScreen({super.key});

  @override
  State<LoanApplyScreen> createState() => _LoanApplyScreenState();
}

class _LoanApplyScreenState extends State<LoanApplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _purposeController = TextEditingController();
  final _durationController = TextEditingController();
  String _loanType = 'individual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Loan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                value: _loanType,
                items: const [
                  DropdownMenuItem(value: 'individual', child: Text('Individual Loan')),
                  DropdownMenuItem(value: 'shg', child: Text('SHG Group Loan')),
                  DropdownMenuItem(value: 'emergency', child: Text('Emergency Loan')),
                ],
                onChanged: (value) => setState(() => _loanType = value!),
                decoration: const InputDecoration(
                  labelText: 'Loan Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _amountController,
                label: 'Loan Amount',
                keyboardType: TextInputType.number,
                isRequired: true,
                validator: (value) => Validators.validateLoanAmount(value),
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _durationController,
                label: 'Duration (months)',
                keyboardType: TextInputType.number,
                isRequired: true,
                validator: (value) => Validators.validateDuration(value),
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _purposeController,
                label: 'Purpose of Loan',
                maxLines: 3,
                isRequired: true,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Submit Application',
                onPressed: _submitApplication,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      // Process loan application
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loan application submitted successfully')),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _purposeController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}