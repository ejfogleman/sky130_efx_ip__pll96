# Chipalooza Rules & Regulations 
[opencircuitdesign.com/chipalooza/rules-4.html](https://opencircuitdesign.com/chipalooza/rules-4.html)

1. All designs created for this challenge must conform to all requirements of the Sky130 process (i.e., DRC, voltage limits, etc.). 

2. The official start date for the Chipalooza Challenge #4 is Monday, November 9, 2026.

3. Final design reviews at the end of February.

5. Proposals are due two weeks from the beginning of the challenge, which is November 23, 2026.

6. Proposals need to provide the following:

    * The type of IP block
    * List of I/O, including test ports
    * Functional description of the IP block
    * A target specification with all relevant characteristics, including average, minimum, and maximum values (as appropriate), and absolute limits.
    * An outline of a test plan for validating the IP block through measurement.
    * List of any equipment available for use in testing (sent separately from the proposal document)
    * CVs of the designers (sent separately from the proposal document)

Note that personal and institutional details are to be left out of the main proposal document. The main proposal document ultimately will be part of the IP block's documentation in its repository. 

7. The proposed IP block should be a block that is useful within the context of a system-on-chip (SoC). This includes all of the IP blocks that were created for the Efabless Chipalooza Challenge #1, as well as additional useful blocks like PLLs, programmable filters, etc. Designers may assume availability of external resources in the form of:

    * Supply voltages at 1.8V (digital) and 3.3V (analog)
    * A bandgap-referenced bias voltage (see voltage reference specification)
    * Up to 2 bandgap-referenced current sources (see current reference specification)
    * Up to 24 digital controls (inputs) and 12 digital test signals (outputs) as needed
    * Up to 4 shared analog signal lines (multiplexed by project)
    * Up to 3 dedicated pins which may be any digital or analog pad from the pad library

Any exceptions to the resource list need to be approved. 

8. Designs from the first Efabless Chipalooza challenge can be found at [github.com/fossi-foundation](https://github.com/fossi-foundation/). A list of projects from the earlier challenge is posted on the Challenge #1 page of these website pages. Participants are welcome to use existing IP as a starting point but are also encouraged to fill gaps in the list of needed useful circuit blocks.

9. The target specification of the circuit is up to the designer, but the specification should be good enough to be attractive to an SoC designer looking for an IP block to use within a system. The design will need to meet the given specification in post-layout verification. Changes to the target specification mid-design must be approved.

10. The harness chip will be designed with a 1.8V logic library and the standard Sky130 PDK dual 1.8V core, 3.3V periphery pad library. Analog designs which expect to operate at the voltage range of the periphery should be designed to operate at 3.3V. Designs which expect to operate at 1.8V on-chip but need to interface to the padframe for testing need to ensure overvoltage protection on their inputs and outputs.

11. Up to 18 designs can be accommodated on a single test chip. The ratio of submitted proposals to completed designs is unknown, so more proposals may be accepted than will fit on the test chip. If more designs are completed through layout and final verification than the test chip can accommodate, then designs will be ranked and some designs may not make it to tapeout. Participants can also share slot space, especially where padframe-facing pins are being underutilized; but keep in mind that sharing a slot makes it more difficult to independently measure the power draw of each circuit.

12. Every design must be put in a public git repository. This may be GitHub, GitLab, Codeberg, or any other as long as it is publicly accessible. The repository must contain all files needed to completely reproduce and verify the IP block as well as use the IP block as a component in a larger system.

13. The design must be verifiable with open source EDA tools. This does not prevent the design from being created with commercial tools, but if the project cannot be verified as meeting specifications with open source tools, then it will be rejected. AI may be used in support of circuit design but must not be a requirement for the end user of the IP block to use, verify, or modify the IP block.

14. All source files needed to generate all views of the design must be available in the repository. It must be possible for anyone using the design to modify the design as needed for their purposes, using open source EDA tools. Designs which cannot be independently verified will not be awarded.

15. The full behavioral description of the circuit must be documented, with documentation available in the repository. Documentation may be in any reasonable format, including plain text, markup, LibreOffice, PDF, etc.

16. Avoid putting unnecessary data dumps into the repository. Sign-off data is required (i.e., final DRC and LVS results). Simulation results should be summarized in plots, not raw data, but it must be possible to reproduce the raw data from the design sources in the repository on demand.

17. Every design must be licensed under a standard open source license, preferably Apache 2.0. Other similar licenses will be considered. In no case may a design use any sources which would violate the terms of the source's license or the Apache 2.0 license.

18. Every design should follow the repository template (once it has been made available). Every attempt will be made to keep the template as flexible as possible. The repository template will contain scripts for running basic sign-off verification, which must be able to run by anyone cloning the repository and show a verified result. An existing template made for the IHP challenge by Simon Dorrer can be found on GitHub at [simi1505/sg13cmos5l_chipalooza_analog_project](https://github.com/simi1505/sg13cmos5l_chipalooza_analog_project/), and while some setup instructions are specific to the IHP process, the template is generally applicable to all challenges. The design environment and workflow are up to the participant, but the template mentioned above has instructions for using the IIC-OSIC-TOOLS workflow, which is encouraged for participants who don't already have an established analog workflow.

19. Post-layout designs must be verified over PVT corners for commercial spec (maximum 110°C is acceptable; a wider spec is obviously preferred).

20. Layout will be restricted to the size of slots available on the test chip to be assembled for Chip Foundry tapeout. The slot size and I/O configuration (TBD) will be specified in the harness repository, with a template layout for the “wrapper” cell around the project IP block. The designer is responsible for wiring up the IP block inside the wrapper cell.

The project should exist in two forms: (1) A standalone layout which can be reused in other chip projects, and (2) The layout inside the slot wrapper specifically for the Chipalooza harness chip. The design should not expand to fill the slot simply because the area is available. Extra slot area may be used for artwork provided that density rules are met. If more than one project shares a slot, each project should still be an independent repository, and only one of them should contain the slot layout, accessing the other project or projects as one or more submodules. Anyone wanting to re-use the circuit for another chip does not want to deal with a Chipalooza harness slot layout!

21. Project slots may have from one to three dedicated pins on the padframe. The user may specify any signal pad, digital or analog, to replace the default analog pads connected to the slot. The pad type will be noted in the harness chip's configuration file and used to build the padframe. With approval, custom pads may be designed by the user. These pads must be the same size and configuration as the foundry pads and must abut cleanly with the foundry pads. The pad layout must be included with the user's project repository. The pad must be completely verified (DRC, LVS, and simulation) independently of the rest of the project.

22. In addition to dedicated pads, each user project slot has access to four analog pins shared with other projects and isolated through switches (analog multiplexers). The switches have a “relatively” low resistance of less than 5 ohms, but each analog bus connects to all eighteen projects, so these shared signals should not be relied on for high-frequency analog signaling.

23. The challenge stages will be gated by reviews. These reviews include:

     * Proposal review (week of November 23)
    * Schematic design and pre-layout simulation review (week of Dec. 28)
    * Layout design and post-layout simulation review (week of Feb. 1, 2027)
    * Final design review (week of Feb. 22, 2027)

24. Slot assignments will be made when the harness chip final design is ready, directly after the layout design review at the latest. The layout design review is for the standalone circuit block, with the final design review for checking the integration of the circuit block into the slot.

25. Designs not ready for tapeout by the final design review may not make it to Chip Foundry tapeout.

26. Awards will be given for all completed designs making it to tapeout and adhering to all rules and regulations. Funding is available for a $1500 award for each project, with half given for successful tapeout and the other half for successful measurement, characterization, and published results.

27. Any updates that modify the terms of the challenge will be announced in the fossi-chat.org/#chipalooza forum. There will be updates regarding specifics of layout and test which have yet to be determined (see “TBD” entries above).

## How is this different from Challenges #2 and #3? 
The supply voltages (1.8V digital, 3.3V analog), pad library, and resource list are specific to the Sky130 process and the Chip Foundry harness chip. This challenge also builds directly on the Sky130 IP from the original Efabless challenge; see [Challenge #1](https://opencircuitdesign.com/chipalooza/challenge-1.html) for what already exists.