import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/input_field.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Contact our support team', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              AppInputField(
                controller: _subjectController,
                label: 'Subject',
                isRequired: true,
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _messageController,
                label: 'Your Message',
                maxLines: 5,
                isRequired: true,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Submit Request',
                onPressed: _submitRequest,
                width: double.infinity,
              ),
              const SizedBox(height: 32),
              const Text('Frequently Asked Questions', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              ExpansionTile(
                title: const Text('How do I apply for a loan?'),
                children: const [Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Go to the Loans section and click on Apply for Loan. Fill in the required details and submit your application.'),
                )],
              ),
              ExpansionTile(
                title: const Text('What are the interest rates?'),
                children: const [Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Interest rates vary between 12-18% per annum depending on loan type and duration.'),
                )],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your support request has been submitted')),
      );
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}