import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMicroLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SmartMicroLabHomePage(),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class SmartMicroLabHomePage extends StatefulWidget {
  const SmartMicroLabHomePage({super.key});

  @override
  State<SmartMicroLabHomePage> createState() => _SmartMicroLabHomePageState();
}

class _SmartMicroLabHomePageState extends State<SmartMicroLabHomePage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  String _currentOrganism = '';

  String _generateResponse(String input) {
    String lowerInput = input.toLowerCase().trim();
    if (lowerInput.contains('e. coli')) {
      _currentOrganism = 'E. coli';
      return '🔬 SmartMicroLab says: E. coli is a type of bacteria (specifically Escherichia coli). It\'s a rod-shaped, Gram-negative bacterium commonly found in the intestines of humans and animals. It plays an important role in microbiology as both a beneficial gut microbe and a potential pathogen causing infections like urinary tract infections. E. coli is widely used in research as a model organism for studying bacterial genetics and biotechnology.';
    } else if (lowerInput.contains('yeast')) {
      _currentOrganism = 'Yeast';
      return '🔬 SmartMicroLab says: Yeast is a type of fungus, specifically Saccharomyces cerevisiae. It\'s a single-celled organism that reproduces by budding. Yeast is important in microbiology for fermentation processes, baking (rising bread), brewing beer, and wine production. It\'s also used as a model organism in genetic research due to its rapid growth and ease of manipulation.';
    } else if (lowerInput == 'start experiment') {
      if (_currentOrganism.isEmpty) {
        return '🔬 SmartMicroLab says: Please specify an organism first by mentioning it (like "E. coli" or "yeast"), then say "Start experiment"!';
      } else if (_currentOrganism == 'E. coli') {
        return '🔬 SmartMicroLab says: Starting experiment for E. coli:\n1. Prepare nutrient agar plates and broth cultures.\n2. Inoculate the plates with E. coli sample using sterile techniques.\n3. Incubate at 37°C for 24 hours.\n4. Observe colony morphology and perform Gram staining.\n5. Conduct biochemical tests like indole, methyl red, Voges-Proskauer, and citrate tests.\n6. Record results and identify based on characteristics.';
      } else if (_currentOrganism == 'Yeast') {
        return '🔬 SmartMicroLab says: Starting experiment for Yeast:\n1. Prepare YPD agar plates and broth.\n2. Inoculate with yeast sample under aseptic conditions.\n3. Incubate at 30°C for 48 hours.\n4. Observe budding and colony appearance.\n5. Perform microscopic examination for cell morphology.\n6. Test fermentation abilities with different sugars.\n7. Document growth patterns and metabolic activities.';
      }
    } else if (lowerInput == 'lab info') {
      return '🔬 SmartMicroLab says: What microbiology concept would you like to learn about? For example, ask about "Gram staining", "fermentation", or "microbial growth curves"! Please specify a topic after "Lab info" like "Lab info Gram staining".';
    } else if (lowerInput.startsWith('lab info')) {
      String topic = lowerInput.substring(8).trim();
      if (topic.toLowerCase().contains('gram staining')) {
        return '🔬 SmartMicroLab says: Gram staining is a technique used to classify bacteria into two main groups: Gram-positive (retain purple stain) and Gram-negative (appear pink). It helps identify bacteria and is crucial for diagnosis and research. The process involves crystal violet, iodine, alcohol/acetone, and safranin dyes.';
      } else if (topic.toLowerCase().contains('fermentation')) {
        return '🔬 SmartMicroLab says: Fermentation is a metabolic process where microorganisms convert sugars into acids, gases, or alcohol in the absence of oxygen. It\'s important for food production (yogurt, cheese, bread) and can be homolactic (lactic acid bacteria) or heterolactic (mixed products). Yeast uses alcoholic fermentation for brewing.';
      } else {
        return '🔬 SmartMicroLab says: I don\'t have info on that topic yet. Try asking about "Gram staining" or "fermentation"!';
      }
    } else if (lowerInput == 'report') {
      if (_currentOrganism.isEmpty) {
        return '🔬 SmartMicroLab says: No experiment in progress. Please start with an organism and experiment first!';
      } else {
        return '🔬 SmartMicroLab says: Report Summary: We studied $_currentOrganism, observed its characteristics, and conducted basic identification tests. Conclusion: $_currentOrganism showed typical growth patterns and biochemical reactions, confirming its identity. This demonstrates fundamental microbiological techniques for organism identification.';
      }
    } else {
      return '🔬 SmartMicroLab says: Hello! I\'m here to help with microbiology. Try mentioning an organism like "E. coli" or "yeast", say "Start experiment", "Lab info" for concepts, or "Report" for summaries!';
    }
    return '';
  }

  void _sendMessage() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: text, isUser: true));
        String response = _generateResponse(text);
        if (response.isNotEmpty) {
          _messages.add(ChatMessage(text: response, isUser: false));
        }
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔬 SmartMicroLab'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message.isUser ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isUser ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about microorganisms or say "Start experiment"...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}