import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static final String _apiKey = 'AIzaSyBVbFQ7-h-2ylCu0Xx9xS5uos2EvgdY1Z0'; // Your Key

  // Local prompt-response database
  static final Map<String, String> localPromptResponses = {
  "you are falling from a great height": "Loss of control or fear of failure.",
  "you are flying without wings": "Freedom, confidence, or spiritual elevation.",
  "you are being chased by someone or something": "Avoidance of a problem or fear in real life.",
  "you are naked in public.": "Vulnerability, shame, or fear of being exposed.",
  "you lose your teeth suddenly.": "Insecurity, aging, or communication anxiety.",
  "you are taking an exam unprepared.": "Stress, fear of failure, or lack of confidence.",
  "you are late for an important event.": "Feeling overwhelmed or fear of missing out.",
  "you’re trapped in a small space.": "Feeling stuck or restricted in life.",
  "you are lost in a big building or city.": "Lack of direction or uncertainty.",
  "you are driving a car out of control.": "Lack of direction or control in your waking life.",
  "you miss a bus, train, or flight.": "Missed opportunities or poor timing.",
  "you see a snake.": "Hidden fears, transformation, or deception.",
  "you are drowning in water.": "Emotional overwhelm or feeling powerless.",
  "you can’t scream or speak.": "Feeling ignored or unable to express yourself.",
  "you lose something valuable.": "Fear of loss or personal insecurity.",
  "you are back in school again.": "Learning lessons, anxiety about performance.",
  "you’re trying to use a phone but it won’t work.": "Communication barriers or disconnection.",
  "you find hidden money or treasure.": "Self-worth, new opportunities, or potential.",
  "you see yourself in a mirror.": "Self-reflection or identity concerns.",
  "you see yourself die.": "Major life change or transformation.",
  "you are crying uncontrollably.": "Emotional release or unresolved sadness.",
  "you are laughing in a strange situation.": "Coping mechanism or emotional imbalance.",
  "you are being attacked by an animal.": "Instinctual fears or anger.",
  "you are floating or levitating.": "Spiritual growth or rising above stress.",
  "you meet a celebrity.": "Aspiration, admiration, or self-recognition.",
  "you find a secret door or room.": "Discovering hidden parts of yourself.",
  "you are in your childhood home.": "Nostalgia, inner child, or unresolved issues.",
  "you are in a beautiful natural landscape.": "Peace, balance, or desire for calm.",
  "you are naked but no one notices.": "Self-acceptance or false fears.",
  "you win a lot of money.": "Desire for abundance or luck.",
  "you lose your voice.": "Powerlessness or lack of influence.",
  "you dream of fire destroying something.": "Anger, transformation, or passion.",
  "you see a loved one crying.": "Empathy, guilt, or emotional concern.",
  "you are stuck in a loop or repeating day.": "Feeling trapped in routine or indecision.",
  "you are being watched or followed.": "Paranoia, guilt, or fear of judgment.",
  "you receive a mysterious letter or message.": "Hidden truth or important realization.",
  "you are getting married.": "Union, commitment, or personal transition.",
  "you see someone else getting married.": "New beginnings or reflecting on relationships.",
  "you are pregnant (regardless of gender).": "New ideas, potential, or growth.",
  "you are in a war zone.": "Inner conflict or external chaos.",
  "you’re flying and suddenly fall.": "Loss of confidence or unexpected failure.",
  "you dream of a robbery or being robbed.": "Violation of boundaries or insecurity.",
  "you are walking endlessly with no destination.": "Searching for purpose or feeling aimless.",
  "you are surrounded by animals.": "Instincts, primal energy, or emotional needs.",
  "you are cooking or eating food.": "Nourishment, creativity, or comfort.",
  "you meet a wise old man or woman.": "Inner guidance or life lessons.",
  "you receive a gift from someone.": "Acknowledgment, love, or self-worth.",
  "you dream of cleaning a messy space.": "Organizing your thoughts, emotions, or life.",
  "you see rain falling gently.": "Cleansing, renewal, or emotional relief.",
  "you wake up and realize you were dreaming inside a dream.": "Heightened awareness or confusion between reality and illusion.",
  "you see your mother dying in a dream.": "Fear of losing emotional support or changes in the mother-child relationship.",
  "you attend your father's funeral while he is alive.": "Desire for independence or changing dynamics with authority figures.",
  "your sibling dies unexpectedly in the dream.": "Fear of drifting apart or unresolved emotions between siblings.",
  "a dead relative comes back to life in the dream.": "Unresolved grief or a message from your subconscious about them.",
  "you see your child die in a dream.": "Fear of failing to protect something precious or anxiety about parenting.",
  "you kill a relative accidentally in a dream.": "Inner conflict or guilt about your relationship with that person.",
  "a relative dies and leaves you something in the dream.": "Inheritance of values, traits, or emotional burdens.",
  "a relative is dying and calls your name.": "They symbolize a part of you or a need to reconnect emotionally.",
  "you see multiple relatives dying at once.": "Feeling overwhelmed by change or fear of losing emotional support systems.",
  "a dying relative gives you a message.": "Your subconscious delivering wisdom or closure through their image.",
  "you cry over a relative’s death in the dream.": "Unexpressed grief or emotional release in your waking life.",
  "you find a dead body of a relative.": "Buried emotions or repressed aspects of your relationship with them.",
  "you are attending a relative’s funeral.": "Symbolic closure or letting go of past emotional attachments.",
  "you speak with a deceased relative.": "Seeking guidance, reassurance, or closure from their memory.",
  "your relative is terminally ill in a dream.": "Fear of loss or feeling helpless in real life situations.",
  "you dream of an unknown relative dying.": "Parts of your ancestry or identity are changing or being left behind.",
  "you save a dying relative in a dream.": "Desire to heal or fix a relationship that feels broken.",
  "your partner or spouse dies in your dream.": "Fear of abandonment or major changes in your relationship.",
  "you ignore a dying relative in the dream.": "Avoidance of emotional responsibility or unresolved guilt.",
  "you dream of reliving a real-life relative’s death.": "Unprocessed grief or trauma re-emerging in your subconscious.",
  "you laugh at a relative’s funeral in a dream.": "Coping with grief in unconventional ways or emotional repression.",
  "your relative turns into a ghost after death in the dream.": "Their memory is haunting you or you feel unsettled about something left unsaid.",
  "you cannot cry at a relative’s death in the dream.": "Emotional numbness or internal conflict about that person.",
  "a relative dies and no one cares in the dream.": "Feeling of isolation, being unheard, or fear of emotional detachment.",
  "your dead relative hugs you in a dream.": "Comfort, love, or a final goodbye coming from your subconscious.",
};


  static Future<String> getInterpretation(String userDream) async {
    // Step 1: First, check in local JSON
    final lowerUserDream = userDream.toLowerCase(); // Normalize input
    for (var prompt in localPromptResponses.keys) {
      if (lowerUserDream.contains(prompt)) {
        return localPromptResponses[prompt]!;
      }
    }

    // Step 2: If not matched locally, use Gemini AI
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro', 
        apiKey: _apiKey,
      );

      final content = [
        Content.text(
          "You're a mystical dream interpreter. Respond in poetic and symbolic language, focusing on Indian spiritual context. Dream: $userDream",
        ),
      ];

      final response = await model.generateContent(content);
      return response.text ?? '⚠ Gemini returned no response.';
    } catch (e) {
      print('⚠ Error during Gemini API call: $e');
      return '⚠ Failed to interpret the dream. Please try again.';
    }
  }
}
