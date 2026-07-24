import '../models/challenge_model.dart';
import '../models/question_model.dart';
import '../models/reward_model.dart';
import '../models/test_result_model.dart';
import '../models/user_model.dart';

/// Static in-memory data standing in for Firestore.
class MockData {
  MockData._();

  static AppUser currentStudent = AppUser(
    uid: 'u_budi',
    username: 'budi01',
    fullName: 'Budi Santoso',
    role: UserRole.student,
    className: 'Kelas 4',
    tpqName: 'TPQ Darul Ishlah',
    points: 640,
    level: 6,
    stars: 14,
    avatarUrl: '',
    createdAt: DateTime(2025, 1, 10),
  );

  static const List<QuizCategory> categories = [
    QuizCategory(
      id: 'aqidah_akhlak',
      name: 'Aqidah & Akhlak',
      description: 'Keimanan dan perilaku terpuji santri',
      iconEmoji: '🕋',
    ),
    QuizCategory(
      id: 'fiqh',
      name: 'Fiqh',
      description: 'Tata cara ibadah dan bersuci',
      iconEmoji: '🕌',
    ),
    QuizCategory(
      id: 'tajwid',
      name: 'Tajwid',
      description: 'Hukum bacaan Al-Qur\'an dengan benar',
      iconEmoji: '📖',
    ),
    QuizCategory(
      id: 'tahsin_kitabah',
      name: 'Tahsin Kitabah',
      description: 'Seni menulis dan memperindah bacaan',
      iconEmoji: '✏️',
    ),
  ];

  static const List<QuizQuestion> aqidahAkhlakQuestions = [
    QuizQuestion(
      id: 'aa1',
      categoryId: 'aqidah_akhlak',
      questionText: 'Rukun Iman yang pertama adalah...',
      options: [
        'Iman kepada Malaikat',
        'Iman kepada Rasul',
        'Iman kepada Allah',
        'Iman kepada Kitab',
      ],
      correctOptionIndex: 2,
      explanation: 'Rukun Iman yang pertama adalah beriman kepada Allah SWT.',
    ),
    QuizQuestion(
      id: 'aa2',
      categoryId: 'aqidah_akhlak',
      questionText: 'Malaikat yang bertugas menyampaikan wahyu kepada para nabi adalah...',
      options: [
        'Mikail',
        'Israfil',
        'Jibril',
        'Izrail',
      ],
      correctOptionIndex: 2,
      explanation: 'Malaikat Jibril memiliki tugas menyampaikan wahyu Allah kepada para nabi dan rasul.',
    ),
    QuizQuestion(
      id: 'aa3',
      categoryId: 'aqidah_akhlak',
      questionText: 'Kitab suci yang diturunkan kepada Nabi Muhammad SAW adalah...',
      options: [
        'Taurat',
        'Zabur',
        'Injil',
        'Al-Qur\'an',
      ],
      correctOptionIndex: 3,
      explanation: 'Al-Qur\'an merupakan kitab terakhir yang diturunkan kepada Nabi Muhammad SAW.',
    ),
    QuizQuestion(
      id: 'aa4',
      categoryId: 'aqidah_akhlak',
      questionText: 'Berbakti kepada kedua orang tua termasuk perilaku...',
      options: [
        'Tercela',
        'Terpuji',
        'Sombong',
        'Munafik',
      ],
      correctOptionIndex: 1,
      explanation: 'Menghormati dan berbakti kepada orang tua merupakan akhlak terpuji.',
    ),
    QuizQuestion(
      id: 'aa5',
      categoryId: 'aqidah_akhlak',
      questionText: 'Rukun Iman yang kelima adalah iman kepada...',
      options: [
        'Kitab Allah',
        'Rasul Allah',
        'Hari Akhir',
        'Qadha dan Qadar',
      ],
      correctOptionIndex: 2,
      explanation: 'Urutan Rukun Iman yang kelima adalah beriman kepada Hari Akhir.',
    ),
    QuizQuestion(
      id: 'aa6',
      categoryId: 'aqidah_akhlak',
      questionText: 'Perilaku yang mencerminkan sifat amanah adalah...',
      options: [
        'Mengingkari janji',
        'Menyimpan barang titipan dengan baik',
        'Berbohong kepada teman',
        'Menyontek saat ujian',
      ],
      correctOptionIndex: 1,
      explanation: 'Amanah berarti dapat dipercaya dan menjaga titipan.',
    ),
    QuizQuestion(
      id: 'aa7',
      categoryId: 'aqidah_akhlak',
      questionText: 'Beriman kepada qadha dan qadar berarti meyakini...',
      options: [
        'Semua manusia pasti kaya',
        'Semua ketentuan Allah yang telah ditetapkan',
        'Semua doa pasti langsung dikabulkan',
        'Semua manusia memiliki nasib yang sama',
      ],
      correctOptionIndex: 1,
      explanation: 'Qadha dan qadar merupakan ketetapan Allah yang wajib diimani.',
    ),
    QuizQuestion(
      id: 'aa8',
      categoryId: 'aqidah_akhlak',
      questionText: 'Perilaku berikut yang menunjukkan akhlak terhadap guru adalah...',
      options: [
        'Membantah ketika dinasihati',
        'Berbicara keras di kelas',
        'Mendengarkan penjelasan guru dengan sopan',
        'Bermain saat guru menjelaskan',
      ],
      correctOptionIndex: 2,
      explanation: 'Menghormati guru termasuk akhlak mulia yang harus diterapkan oleh setiap muslim.',
    ),
    QuizQuestion(
      id: 'aa9',
      categoryId: 'aqidah_akhlak',
      questionText: 'Hari ketika seluruh manusia dibangkitkan dari kubur disebut...',
      options: [
        'Yaumul Hisab',
        'Yaumul Mahsyar',
        'Yaumul Ba\'ats',
        'Yaumul Mizan',
      ],
      correctOptionIndex: 2,
      explanation: 'Yaumul Ba\'ats adalah hari dibangkitkannya manusia dari alam kubur.',
    ),
    QuizQuestion(
      id: 'aa10',
      categoryId: 'aqidah_akhlak',
      questionText: 'Salah satu hikmah beriman kepada malaikat adalah...',
      options: [
        'Menjadi malas beribadah',
        'Selalu merasa diawasi sehingga lebih berhati-hati dalam berbuat',
        'Takut kepada manusia',
        'Tidak mau berteman',
      ],
      correctOptionIndex: 1,
      explanation: 'Keimanan kepada malaikat mendorong seseorang untuk selalu berbuat baik karena yakin setiap amal dicatat oleh malaikat.',
    ),
  ];

  static const List<QuizQuestion> fiqhQuestions = [
    QuizQuestion(
      id: 'fq1',
      categoryId: 'fiqh',
      questionText: 'Sebelum melaksanakan shalat, seorang muslim wajib dalam keadaan...',
      options: [
        'Lapar',
        'Suci dari hadas',
        'Menggunakan pakaian baru',
        'Berpuasa',
      ],
      correctOptionIndex: 1,
      explanation: 'Sebelum shalat, kita wajib suci dari hadas kecil maupun besar dengan berwudhu atau bertayamum.',
    ),
    QuizQuestion(
      id: 'fq2',
      categoryId: 'fiqh',
      questionText: 'Rukun Islam yang kedua adalah...',
      options: [
        'Puasa',
        'Zakat',
        'Shalat',
        'Haji',
      ],
      correctOptionIndex: 2,
      explanation: 'Rukun Islam yang kedua setelah syahadat adalah mendirikan shalat lima waktu.',
    ),
    QuizQuestion(
      id: 'fq3',
      categoryId: 'fiqh',
      questionText: 'Jumlah rakaat shalat Maghrib adalah...',
      options: [
        '2',
        '3',
        '4',
        '5',
      ],
      correctOptionIndex: 1,
      explanation: 'Shalat Maghrib terdiri dari 3 rakaat.',
    ),
    QuizQuestion(
      id: 'fq4',
      categoryId: 'fiqh',
      questionText: 'Membasuh kedua tangan sampai siku merupakan...',
      options: [
        'Sunnah Wudhu',
        'Rukun Wudhu',
        'Syarat Wudhu',
        'Adab Wudhu',
      ],
      correctOptionIndex: 1,
      explanation: 'Membasuh kedua tangan sampai siku termasuk salah satu rukun wudhu yang wajib dipenuhi.',
    ),
    QuizQuestion(
      id: 'fq5',
      categoryId: 'fiqh',
      questionText: 'Yang membatalkan wudhu adalah...',
      options: [
        'Tidur nyenyak',
        'Membaca Al-Qur\'an',
        'Berdzikir',
        'Bersedekah',
      ],
      correctOptionIndex: 0,
      explanation: 'Tidur nyenyak yang menghilangkan kesadaran merupakan salah satu hal yang membatalkan wudhu.',
    ),
    QuizQuestion(
      id: 'fq6',
      categoryId: 'fiqh',
      questionText: 'Shalat lima waktu hukumnya...',
      options: [
        'Sunnah',
        'Wajib',
        'Makruh',
        'Mubah',
      ],
      correctOptionIndex: 1,
      explanation: 'Mendirikan shalat lima waktu sehari semalam hukumnya wajib (fardhu \'ain) bagi setiap muslim yang baligh.',
    ),
    QuizQuestion(
      id: 'fq7',
      categoryId: 'fiqh',
      questionText: 'Apabila tidak ada air, bersuci dilakukan dengan...',
      options: [
        'Istinja\'',
        'Tayamum',
        'Mandi',
        'Berwudhu ulang',
      ],
      correctOptionIndex: 1,
      explanation: 'Tayamum adalah pengganti wudhu atau mandi wajib menggunakan debu suci jika tidak menemukan air.',
    ),
    QuizQuestion(
      id: 'fq8',
      categoryId: 'fiqh',
      questionText: 'Menghadap kiblat termasuk...',
      options: [
        'Sunnah Shalat',
        'Syarat Sah Shalat',
        'Rukun Wudhu',
        'Sunnah Wudhu',
      ],
      correctOptionIndex: 1,
      explanation: 'Menghadap kiblat (Ka\'bah) merupakan salah satu syarat sah shalat.',
    ),
    QuizQuestion(
      id: 'fq9',
      categoryId: 'fiqh',
      questionText: 'Niat dalam ibadah dilakukan...',
      options: [
        'Setelah salam',
        'Sebelum memulai ibadah',
        'Setelah selesai shalat',
        'Setelah membaca doa',
      ],
      correctOptionIndex: 1,
      explanation: 'Niat dalam setiap ibadah harus dilakukan sebelum atau saat memulai ibadah tersebut.',
    ),
    QuizQuestion(
      id: 'fq10',
      categoryId: 'fiqh',
      questionText: 'Najis yang dapat disucikan dengan memercikkan air adalah...',
      options: [
        'Najis Mughalazhah',
        'Najis Mukhafafah',
        'Najis Mutawassithah',
        'Semua najis',
      ],
      correctOptionIndex: 1,
      explanation: 'Najis mukhaffafah (najis ringan) seperti air kencing bayi laki-laki di bawah 2 tahun cukup disucikan dengan memercikkan air.',
    ),
  ];

  static const List<QuizQuestion> tajwidQuestions = [
    QuizQuestion(
      id: 'tj1',
      categoryId: 'tajwid',
      questionText: 'Ilmu yang mempelajari cara membaca Al-Qur\'an dengan benar disebut...',
      options: [
        'Nahwu',
        'Sharaf',
        'Tajwid',
        'Fiqih',
      ],
      correctOptionIndex: 2,
      explanation: 'Ilmu Tajwid adalah ilmu untuk membaguskan dan melafalkan huruf-huruf Al-Qur\'an dengan benar sesuai tempat keluarnya (makhraj) dan sifatnya.',
    ),
    QuizQuestion(
      id: 'tj2',
      categoryId: 'tajwid',
      questionText: 'Huruf Qalqalah berjumlah...',
      options: [
        '3',
        '4',
        '5',
        '6',
      ],
      correctOptionIndex: 2,
      explanation: 'Huruf qalqalah ada 5, dikumpulkan dalam singkatan (قُطْبُ جَدٍ) yaitu Qaf, Tha, Ba, Jim, dan Dal.',
    ),
    QuizQuestion(
      id: 'tj3',
      categoryId: 'tajwid',
      questionText: 'Mad Thabi\'i dibaca sepanjang...',
      options: [
        '1 harakat',
        '2 harakat',
        '4 harakat',
        '6 harakat',
      ],
      correctOptionIndex: 1,
      explanation: 'Mad Thabi\'i atau Mad Asli dibaca sepanjang 1 alif atau 2 harakat.',
    ),
    QuizQuestion(
      id: 'tj4',
      categoryId: 'tajwid',
      questionText: 'Apabila Nun Sukun bertemu huruf Ba, hukumnya adalah...',
      options: [
        'Izhar',
        'Idgham',
        'Iqlab',
        'Ikhfa\'',
      ],
      correctOptionIndex: 2,
      explanation: 'Hukum bacaan Iqlab terjadi jika nun mati atau tanwin bertemu dengan huruf Ba (ب).',
    ),
    QuizQuestion(
      id: 'tj5',
      categoryId: 'tajwid',
      questionText: 'Apabila Mim Sukun bertemu Mim, hukumnya adalah...',
      options: [
        'Izhar Syafawi',
        'Idgham Mimi',
        'Ikhfa\' Syafawi',
        'Iqlab',
      ],
      correctOptionIndex: 1,
      explanation: 'Idgham Mimi (atau Idgham Mutamatsilain) terjadi ketika mim sukun bertemu dengan sesama huruf mim (م).',
    ),
    QuizQuestion(
      id: 'tj6',
      categoryId: 'tajwid',
      questionText: 'Qalqalah berarti membaca huruf dengan...',
      options: [
        'Dengung',
        'Pantulan',
        'Panjang',
        'Cepat',
      ],
      correctOptionIndex: 1,
      explanation: 'Secara bahasa, qalqalah artinya getaran atau pantulan suara saat melafalkan huruf qalqalah yang bersukun/mati.',
    ),
    QuizQuestion(
      id: 'tj7',
      categoryId: 'tajwid',
      questionText: 'Jumlah huruf Ikhfa\' adalah...',
      options: [
        '10',
        '12',
        '15',
        '18',
      ],
      correctOptionIndex: 2,
      explanation: 'Huruf ikhfa\' hakiki berjumlah 15 huruf.',
    ),
    QuizQuestion(
      id: 'tj8',
      categoryId: 'tajwid',
      questionText: 'Mad Jaiz Munfasil dibaca...',
      options: [
        '2 harakat',
        '2–5 harakat',
        '6 harakat',
        '1 harakat',
      ],
      correctOptionIndex: 1,
      explanation: 'Mad Jaiz Munfasil dibaca sepanjang 2 sampai 5 harakat.',
    ),
    QuizQuestion(
      id: 'tj9',
      categoryId: 'tajwid',
      questionText: 'Makharijul huruf adalah...',
      options: [
        'Tempat keluarnya huruf',
        'Tempat berhenti membaca',
        'Tempat memulai membaca',
        'Tempat menulis huruf',
      ],
      correctOptionIndex: 0,
      explanation: 'Makharijul huruf secara bahasa berarti tempat-tempat keluarnya huruf saat melafalkannya.',
    ),
    QuizQuestion(
      id: 'tj10',
      categoryId: 'tajwid',
      questionText: 'Tujuan mempelajari tajwid adalah...',
      options: [
        'Agar cepat membaca',
        'Agar membaca Al-Qur\'an sesuai kaidah yang benar',
        'Agar hafal semua surat',
        'Agar tulisan menjadi bagus',
      ],
      correctOptionIndex: 1,
      explanation: 'Mempelajari tajwid bertujuan agar kita dapat membaca ayat-ayat Al-Qur\'an secara tartil, fasih, dan terhindar dari kesalahan bacaan.',
    ),
  ];

  static const List<QuizQuestion> tahsinKitabahQuestions = [
    QuizQuestion(
      id: 'tk1',
      categoryId: 'tahsin_kitabah',
      questionText: 'Tahsin berarti...',
      options: [
        'Menulis',
        'Memperindah bacaan Al-Qur\'an',
        'Menghafal',
        'Menerjemahkan',
      ],
      correctOptionIndex: 1,
      explanation: 'Tahsin berasal dari kata hassana yang berarti membaguskan, memperbaiki, atau memperindah bacaan Al-Qur\'an.',
    ),
    QuizQuestion(
      id: 'tk2',
      categoryId: 'tahsin_kitabah',
      questionText: 'Kitabah berarti...',
      options: [
        'Membaca',
        'Menulis',
        'Menghafal',
        'Mendengarkan',
      ],
      correctOptionIndex: 1,
      explanation: 'Kitabah berasal dari kata kataba yang berarti menulis huruf, kata, atau kalimat Arab.',
    ),
    QuizQuestion(
      id: 'tk3',
      categoryId: 'tahsin_kitabah',
      questionText: 'Huruf pertama dalam hijaiyah adalah...',
      options: [
        'ب',
        'ت',
        'ا',
        'ث',
      ],
      correctOptionIndex: 2,
      explanation: 'Huruf hijaiyah pertama adalah Alif (ا).',
    ),
    QuizQuestion(
      id: 'tk4',
      categoryId: 'tahsin_kitabah',
      questionText: 'Tujuan tahsin adalah...',
      options: [
        'Mempercepat membaca',
        'Memperbaiki bacaan sesuai makhraj dan tajwid',
        'Menghafal semua juz',
        'Menulis huruf Arab',
      ],
      correctOptionIndex: 1,
      explanation: 'Tujuan tahsin adalah memperbaiki cara melafalkan huruf dan ayat Al-Qur\'an agar sesuai makhraj dan hukum tajwid.',
    ),
    QuizQuestion(
      id: 'tk5',
      categoryId: 'tahsin_kitabah',
      questionText: 'Dalam kitabah, setiap huruf hijaiyah harus ditulis...',
      options: [
        'Sesuai bentuk yang benar',
        'Bebas',
        'Menggunakan huruf latin',
        'Tidak perlu harakat',
      ],
      correctOptionIndex: 0,
      explanation: 'Huruf hijaiyah harus ditulis sesuai kaidah penulisan (khat) yang benar agar maknanya tepat.',
    ),
    QuizQuestion(
      id: 'tk6',
      categoryId: 'tahsin_kitabah',
      questionText: 'Harakat fathah menghasilkan bunyi...',
      options: [
        'i',
        'u',
        'a',
        'ai',
      ],
      correctOptionIndex: 2,
      explanation: 'Harakat fathah (garis di atas huruf) berbunyi vokal \'a\'.',
    ),
    QuizQuestion(
      id: 'tk7',
      categoryId: 'tahsin_kitabah',
      questionText: 'Huruf yang ditulis dari kanan ke kiri adalah...',
      options: [
        'Huruf Latin',
        'Huruf Arab',
        'Huruf Romawi',
        'Huruf Jepang',
      ],
      correctOptionIndex: 1,
      explanation: 'Sistem penulisan huruf Arab (kitabah) dimulai dari sisi kanan ke kiri.',
    ),
    QuizQuestion(
      id: 'tk8',
      categoryId: 'tahsin_kitabah',
      questionText: 'Saat membaca Al-Qur\'an, yang harus diperhatikan selain tajwid adalah...',
      options: [
        'Warna mushaf',
        'Makhraj huruf dan kelancaran bacaan',
        'Ukuran huruf',
        'Tebal tipis kertas',
      ],
      correctOptionIndex: 1,
      explanation: 'Kita harus memperhatikan pelafalan makhraj huruf dengan fasih dan kelancaran membaca saat tahsin.',
    ),
    QuizQuestion(
      id: 'tk9',
      categoryId: 'tahsin_kitabah',
      questionText: 'Kitabah melatih kemampuan santri dalam...',
      options: [
        'Menulis huruf dan kata Arab dengan benar',
        'Menggambar',
        'Berpidato',
        'Berhitung',
      ],
      correctOptionIndex: 0,
      explanation: 'Pembelajaran kitabah dirancang khusus untuk melatih ketangkasan dan kebenaran menulis aksara Arab.',
    ),
    QuizQuestion(
      id: 'tk10',
      categoryId: 'tahsin_kitabah',
      questionText: 'Tahsin dan kitabah memiliki tujuan utama yaitu...',
      options: [
        'Meningkatkan kemampuan membaca dan menulis Al-Qur\'an dengan baik dan benar',
        'Mempercepat hafalan',
        'Mempermudah berhitung',
        'Memperindah tulisan latin',
      ],
      correctOptionIndex: 0,
      explanation: 'Gabungan tahsin dan kitabah melatih santri agar mahir membaca (tahsin) sekaligus menulis (kitabah) ayat-ayat suci.',
    ),
  ];

  static const List<Reward> rewards = [
    Reward(
      id: 'r1',
      name: 'Stiker Bintang Emas',
      description: 'Stiker eksklusif untuk buku catatan',
      iconEmoji: '⭐',
      pointsRequired: 200,
    ),
    Reward(
      id: 'r2',
      name: 'Sertifikat Santri Teladan',
      description: 'Sertifikat cetak untuk dipajang',
      iconEmoji: '🏅',
      pointsRequired: 500,
    ),
    Reward(
      id: 'r3',
      name: 'Alat Tulis TPQ',
      description: 'Satu set pensil dan penggaris',
      iconEmoji: '✏️',
      pointsRequired: 800,
    ),
    Reward(
      id: 'r4',
      name: 'Buku Iqra Baru',
      description: 'Buku Iqra edisi bergambar',
      iconEmoji: '📗',
      pointsRequired: 1200,
    ),
  ];

  static const List<LeaderboardEntry> leaderboard = [
    LeaderboardEntry(
      userId: 'u_aisyah',
      fullName: 'Aisyah Putri',
      avatarUrl: '',
      points: 980,
      level: 9,
    ),
    LeaderboardEntry(
      userId: 'u_zaid',
      fullName: 'Zaid Rahman',
      avatarUrl: '',
      points: 875,
      level: 8,
    ),
    LeaderboardEntry(
      userId: 'u_fatima',
      fullName: 'Fatima Azzahra',
      avatarUrl: '',
      points: 710,
      level: 7,
    ),
    LeaderboardEntry(
      userId: 'u_budi',
      fullName: 'Budi Santoso',
      avatarUrl: '',
      points: 640,
      level: 6,
    ),
    LeaderboardEntry(
      userId: 'u_rian',
      fullName: 'Rian Maulana',
      avatarUrl: '',
      points: 590,
      level: 6,
    ),
    LeaderboardEntry(
      userId: 'u_dewi',
      fullName: 'Dewi Lestari',
      avatarUrl: '',
      points: 430,
      level: 4,
    ),
  ];

  static List<QuizQuestion> getQuestionsForCategory(String categoryId) {
    switch (categoryId) {
      case 'aqidah_akhlak':
        return aqidahAkhlakQuestions;
      case 'fiqh':
        return fiqhQuestions;
      case 'tajwid':
        return tajwidQuestions;
      case 'tahsin_kitabah':
        return tahsinKitabahQuestions;
      default:
        return [];
    }
  }

  static List<DailyChallenge> dailyChallenges = [
    const DailyChallenge(
      id: 'dc1',
      title: 'Kuis Kilat',
      description: 'Selesaikan 1 kuis kategori apa saja hari ini',
      iconEmoji: '⚡',
      pointsReward: 50,
      progress: 1.0,
      isCompleted: true,
      isClaimed: false,
    ),
    const DailyChallenge(
      id: 'dc2',
      title: 'Santri Sempurna',
      description: 'Dapatkan nilai 100 di kuis apa saja',
      iconEmoji: '⭐',
      pointsReward: 100,
      progress: 0.0,
      isCompleted: false,
    ),
    const DailyChallenge(
      id: 'dc3',
      title: 'Shalat Berjamaah',
      description: 'Laksanakan shalat wajib secara berjamaah',
      iconEmoji: '🕌',
      pointsReward: 80,
      progress: 1.0,
      isCompleted: true,
      isClaimed: true,
    ),
    const DailyChallenge(
      id: 'dc4',
      title: 'Senyum & Salam',
      description: 'Uchapkan salam dan cium tangan orang tua/guru',
      iconEmoji: '🤲',
      pointsReward: 40,
      progress: 0.0,
      isCompleted: false,
    ),
  ];

  static void claimChallenge(String challengeId) {
    final index = dailyChallenges.indexWhere((c) => c.id == challengeId);
    if (index != -1) {
      final oldChallenge = dailyChallenges[index];
      if (oldChallenge.isCompleted && !oldChallenge.isClaimed) {
        dailyChallenges[index] = oldChallenge.copyWith(isClaimed: true);
        final currentPoints = currentStudent.points;
        currentStudent = currentStudent.copyWith(
          points: currentPoints + oldChallenge.pointsReward,
        );
      }
    }
  }

  static TestResult buildResult({
    required String categoryId,
    required int correctCount,
    required int totalCount,
  }) {
    final score = ((correctCount / totalCount) * 100).round();
    return TestResult(
      id: 'result_${DateTime.now().millisecondsSinceEpoch}',
      userId: currentStudent.uid,
      categoryId: categoryId,
      score: score,
      correctCount: correctCount,
      wrongCount: totalCount - correctCount,
      starsEarned: TestResult.starsForScore(score),
      createdAt: DateTime.now(),
    );
  }
}
