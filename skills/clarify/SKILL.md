name: clarify

description: >

  Lightweight clarification gate before execution. Ask up to 3 focused

  questions when a request is genuinely ambiguous, then proceed immediately.

  Use when the user says "clarify", "clarify first", "check with me", or

  prefixes a request with "cw". Also use when the user says "do not hesitate

  to ask me any clarifying questions" or similar phrasing that grants

  permission to ask before acting.

---

 

# Clarify — Ask Before Assuming

 

A minimal-friction skill that gives you explicit permission to pause and ask

clarifying questions when a request has genuine ambiguity — then get to work.

 

This is NOT an interview. This is a quick checkpoint.

 

---

 

## Behavior

 

1. **Read the request.** Determine whether there is genuine ambiguity — meaning

   multiple valid interpretations exist, or missing context would meaningfully

   change your approach.

 

2. **If ambiguous:** Ask up to 3 clarifying questions. Batch them in a single

   message. Be specific and direct — no preamble, no "great question" filler.

 

3. **If clear:** Skip straight to execution. Do not ask questions for the sake

   of asking. Confidence is the default.

 

4. **After answers:** Proceed immediately to the work. No summary, no

   confirmation step, no "okay here's what I understood." Just do the thing.

 

---

 

## Rules

 

- **Max 3 questions.** If you need more than 3, you're overthinking it — pick

  the 3 that would most change your approach and make reasonable assumptions

  for the rest.

- **Batch questions together.** Never drip-feed one at a time.

- **Only genuine ambiguity.** Do not ask when:

  - You can infer the answer from context (codebase, conversation history,

    file contents).

  - The choice is trivial or easily reversible.

  - You're just being polite.

- **No ceremony.** No "let me make sure we're aligned," no phase labels, no

  recap documents.

- **Proceed after one round.** You get one shot to ask. After the user

  responds, execute. Do not follow up with more questions.
