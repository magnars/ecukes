(require 'ecukes-stats)

(ert-deftest stats-reset ()
  "Should reset stats."
  (with-stats
   (setq ecukes-stats-steps 1)
   (setq ecukes-stats-steps-passed 2)
   (setq ecukes-stats-steps-failed 3)
   (setq ecukes-stats-steps-skipped 4)
   (setq ecukes-stats-scenarios 5)
   (setq ecukes-stats-scenarios-passed 6)
   (setq ecukes-stats-scenarios-failed 7)

   (ecukes-stats-reset)

   (should (equal ecukes-stats-steps 0))
   (should (equal ecukes-stats-steps-passed 0))
   (should (equal ecukes-stats-steps-failed 0))
   (should (equal ecukes-stats-steps-skipped 0))
   (should (equal ecukes-stats-scenarios 0))
   (should (equal ecukes-stats-scenarios-passed 0))
   (should (equal ecukes-stats-scenarios-failed 0))))

(ert-deftest stats-update-num-steps ()
  "Should update number of steps."
  (with-stats
   (ecukes-stats-step-pass)
   (ecukes-stats-step-fail)
   (ecukes-stats-step-skip)
   (should (equal ecukes-stats-steps 3))))

(ert-deftest stats-update-passed-steps ()
  "Should update number of passed steps."
  (with-stats
   (ecukes-stats-step-pass)
   (should (equal ecukes-stats-steps-passed 1))
   (should (equal ecukes-stats-steps 1))))

(ert-deftest stats-update-failed-steps ()
  "Should update number of failed steps."
  (with-stats
   (ecukes-stats-step-fail)
   (should (equal ecukes-stats-steps-failed 1))
   (should (equal ecukes-stats-steps 1))))

(ert-deftest stats-update-skipped-steps ()
  "Should update number of skipped steps."
  (with-stats
   (ecukes-stats-step-skip)
   (should (equal ecukes-stats-steps-skipped 1))
   (should (equal ecukes-stats-steps 1))))

(ert-deftest stats-update-num-scenarios ()
  "Should update number of scenarios."
  (with-stats
   (ecukes-stats-scenario-pass)
   (ecukes-stats-scenario-fail)
   (should (equal ecukes-stats-scenarios 2))))

(ert-deftest stats-update-passed-scenarios ()
  "Should update number of passed scenarios."
  (with-stats
   (ecukes-stats-scenario-pass)
   (should (equal ecukes-stats-scenarios-passed 1))
   (should (equal ecukes-stats-scenarios 1))))

(ert-deftest stats-update-failed-scenarios ()
  "Should update number of failed scenarios."
  (with-stats
   (ecukes-stats-scenario-fail)
   (should (equal ecukes-stats-scenarios-failed 1))
   (should (equal ecukes-stats-scenarios 1))))

(ert-deftest stats-step-summary-no-steps ()
  "Should show only total (zero) when no steps."
  (with-stats
   (should (equal (ecukes-stats-step-summary) "0 steps"))))

(ert-deftest stats-step-summary-only-passed ()
  "Should show only passed steps."
  (with-stats
   (ecukes-stats-step-pass)
   (ecukes-stats-step-pass)
   (should
    (equal
     (ecukes-stats-step-summary)
     (format
      "2 steps (%s, %s, %s)"
      (ansi-red "0 failed")
      (ansi-cyan "0 skipped")
      (ansi-green "2 passed"))))))

(ert-deftest stats-step-summary-only-failed ()
  "Should show only failed steps."
  (with-stats
   (ecukes-stats-step-fail)
   (ecukes-stats-step-fail)
   (should
    (equal
     (ecukes-stats-step-summary)
     (format
      "2 steps (%s, %s, %s)"
      (ansi-red "2 failed")
      (ansi-cyan "0 skipped")
      (ansi-green "0 passed"))))))

(ert-deftest stats-step-summary-passed-and-failed ()
  "Should show passed and failed steps."
  (with-stats
   (ecukes-stats-step-pass)
   (ecukes-stats-step-fail)
   (should
    (equal
     (ecukes-stats-step-summary)
     (format
      "2 steps (%s, %s, %s)"
      (ansi-red "1 failed")
      (ansi-cyan "0 skipped")
      (ansi-green "1 passed"))))))

(ert-deftest stats-step-summary-passed-failed-and-skipped ()
  "Should show only passed, faild and skipped steps."
  (with-stats
   (ecukes-stats-step-pass)
   (ecukes-stats-step-fail)
   (ecukes-stats-step-skip)
   (should
    (equal
     (ecukes-stats-step-summary)
     (format
      "3 steps (%s, %s, %s)"
      (ansi-red "1 failed")
      (ansi-cyan "1 skipped")
      (ansi-green "1 passed"))))))

(ert-deftest stats-scenario-summary-no-scenarios ()
  "Should show only total (zero) when no scenarios."
  (with-stats
   (should (equal (ecukes-stats-scenario-summary) "0 scenarios"))))

(ert-deftest stats-scenario-summary-only-passed ()
  "Should show only passed scenarios."
  (with-stats
   (ecukes-stats-scenario-pass)
   (ecukes-stats-scenario-pass)
   (should
    (equal
     (ecukes-stats-scenario-summary)
     (format
      "2 scenarios (%s, %s)"
      (ansi-red "0 failed")
      (ansi-green "2 passed"))))))

(ert-deftest stats-scenario-summary-only-failed ()
  "Should show only failed scenarios."
  (with-stats
   (ecukes-stats-scenario-fail)
   (ecukes-stats-scenario-fail)
   (should
    (equal
     (ecukes-stats-scenario-summary)
     (format
      "2 scenarios (%s, %s)"
      (ansi-red "2 failed")
      (ansi-green "0 passed"))))))

(ert-deftest stats-scenario-summary-passed-and-failed ()
  "Should show passed and failed scenarios."
  (with-stats
   (ecukes-stats-scenario-pass)
   (ecukes-stats-scenario-fail)
   (should
    (equal
     (ecukes-stats-scenario-summary)
     (format
      "2 scenarios (%s, %s)"
      (ansi-red "1 failed")
      (ansi-green "1 passed"))))))

(ert-deftest stats-summary-no-scenarios-or-steps ()
  "Should show both scenarios and steps when no scenarios or steps."
  (with-stats
   (should (equal (ecukes-stats-summary) "0 scenarios\n0 steps"))))

(ert-deftest stats-summary-with-scenarios-or-steps ()
  "Should show both scenarios and steps when both scenarios and steps."
  (with-stats
   (ecukes-stats-scenario-pass)
   (ecukes-stats-scenario-fail)
   (ecukes-stats-step-pass)
   (ecukes-stats-step-fail)
   (ecukes-stats-step-skip)
   (should
    (equal
     (ecukes-stats-summary)
     (format
      "%s\n%s"
      (format
       "2 scenarios (%s, %s)"
       (ansi-red "1 failed")
       (ansi-green "1 passed"))
      (format
       "3 steps (%s, %s, %s)"
       (ansi-red "1 failed")
       (ansi-cyan "1 skipped")
       (ansi-green "1 passed")))))))
